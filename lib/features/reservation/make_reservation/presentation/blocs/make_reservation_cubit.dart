import 'dart:async';
import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/features/reservation/data/hospital.dart';
import 'package:cloud_medix/features/reservation/domain/hospitals_repository.dart';
import 'package:cloud_medix/features/reservation/make_reservation/data/slot.dart';
import 'package:cloud_medix/features/reservation/make_reservation/domain/make_reservation_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
part 'make_reservation_state.dart';

class MakeReservationCubit extends Cubit<MakeReservationState> {
  bool slotsFetched = false;

  final MakeReservationRespository makeResRepo =
      getIt<MakeReservationRespository>();
  final HospitalsRespository hospitalsRepo = getIt<HospitalsRespository>();
  int? selectedHospitalId;
  List<Slot> slots = [];
  List<Hospital> hospitals = [];
  late ApiResponse response;
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();
  String doctorFilter = '';
  String departmentFilter = '';

  MakeReservationCubit() : super(const MakeReservationInitial());
  Future<void> init() async {
    await getHospitals();
  }

  Future<void> updateSlotsUI() async {
    final prefs = await SharedPreferences.getInstance();
    const String key = "hospital_slot_map";
    // await prefs.remove("hospital_slot_map");

    final userId = await storage.read(key: "id");
    final hospitalKey = selectedHospitalId?.toString();

    if (userId == null || hospitalKey == null) return;

    final existingData = prefs.getString(key);

    if (existingData == null) return;

    final Map<String, dynamic> userMap = jsonDecode(existingData);

    if (!userMap.containsKey(userId)) return;

    final hospitalMap = Map<String, dynamic>.from(userMap[userId]);

    List<int> reservedSlotIds = [];

    if (hospitalMap.containsKey(hospitalKey)) {
      final List<dynamic> slotList = hospitalMap[hospitalKey];

      reservedSlotIds = slotList
          .map((slotJson) =>
              Slot.fromJson(Map<String, dynamic>.from(slotJson)).id)
          .toList();
    }

    slots = slots.map((slot) {
      final isReserved = reservedSlotIds.contains(slot.id);
      return slot.copyWith(reserved: isReserved);
    }).toList();
  }

  Future<void> reserveSlot(int slotID) async {
    emit(MakeReservationProcessLoading(List.from(slots))); // Show loading

    String? userId = await storage.read(key: "id");
    selectedHospitalId = selectedHospitalId ?? hospitals[0].id;

    if (userId == null || selectedHospitalId == null) {
      emit(const MakeReservationError("Server Error or User error Id"));
      return;
    }

    await makeResRepo.makeHospitalReservation(
        userId, selectedHospitalId!, slotID);

    int index = slots.indexWhere((slot) => slot.id == slotID);
    if (index != -1) {
      slots[index] = slots[index].copyWith(reserved: true);
    }

    // Save mapping to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    const String key = "hospital_slot_map";

    final existingData = prefs.getString(key);
    Map<String, dynamic> userMap = {};

    if (existingData != null) {
      userMap = jsonDecode(existingData);
    }

    final hospitalKey = selectedHospitalId!.toString();
    final userKey = userId;

    Map<String, List<Map<String, dynamic>>> hospitalMap = {};

    if (userMap.containsKey(userKey)) {
      // Deserialize hospital map for this user
      final raw = userMap[userKey] as Map<String, dynamic>;
      hospitalMap =
          raw.map((k, v) => MapEntry(k, List<Map<String, dynamic>>.from(v)));
    }

    // Add or update the slot for the hospital
    List<Map<String, dynamic>> updatedSlots =
        hospitalMap[hospitalKey]?.where((s) => s['id'] != slotID).toList() ??
            [];

    updatedSlots.add(slots[index].toJson());
    hospitalMap[hospitalKey] = updatedSlots;

    // Save back to user map
    userMap[userKey] = hospitalMap;

    await prefs.setString(key, jsonEncode(userMap));

    emit(MakeReservationLoaded(List.from(slots)));
  }

  Future<void> getHospitals() async {
    final cached =
        await hospitalsRepo.getCachedHospitals(); // 1. Try cache first

    if (cached.isNotEmpty) {
      hospitals = cached;
      return;
    }

    // 2. If no cache, fetch from API
    response = await hospitalsRepo.getRegisteredHospitals();

    if (response.status == 200 &&
        response.data != null &&
        response.data!.isNotEmpty) {
      hospitals = response.data!;
      await hospitalsRepo.cacheHospitals(hospitals); // ✅ Save to cache
    } else {
      emit(MakeReservationError(response.error ?? "No hospitals available."));
    }
  }

  Future<void> changeHospital(int hospitalId) async {
    emit(const MakeReservationLoading());
    selectedHospitalId = hospitalId;

    String? userId = await storage.read(key: "id");
    if (userId == null) {
      emit(const MakeReservationError("User ID is missing"));
      return;
    }

    response = await makeResRepo.getHospitalSlots(userId, hospitalId);

    if (response.status == 200 &&
        response.data != null &&
        response.data!.isNotEmpty) {
      slots = response.data!;

      // Load reserved slots from SharedPreferences
      await updateSlotsUI();

      emit(MakeReservationLoaded(List.from(slots)));
    } else if (response.status == 200 &&
        response.data != null &&
        response.data!.isEmpty) {
      slots = [];
      emit(MakeReservationLoaded(List.from(slots)));
    } else {
      final errorMessage = response.error ?? "Error, Try Again Later";
      emit(MakeReservationError(errorMessage));
    }
  }

  Future<void> getSlots(bool isRefresh) async {
    // if (slotsFetched) return;
    // slotsFetched = true;
    isRefresh
        ? emit(MakeReservationProcessLoading(slots))
        : emit(const MakeReservationLoading());

    String? id = await storage.read(key: "id");
    if (id == null) {
      emit(const MakeReservationError("User ID is missing Error"));
      return;
    } else {
      if (hospitals.isEmpty) {
        await getHospitals();
      }

      selectedHospitalId = selectedHospitalId ?? hospitals[0].id;

      response = await makeResRepo.getHospitalSlots(id, selectedHospitalId!);

      if (response.status == 200 &&
          response.data != null &&
          response.data!.isNotEmpty) {
        slots = response.data!;

        // Load reserved slots from SharedPreferences
        final today = DateTime.now();
        final todayDate = DateTime(today.year, today.month, today.day);
        slots = slots.where((slot) {
          final slotDate = DateTime(
              slot.startTime.year, slot.startTime.month, slot.startTime.day);
          return slotDate.isAtSameMomentAs(todayDate) ||
              slotDate.isAfter(todayDate);
        }).toList();
        await updateSlotsUI();

        emit(MakeReservationLoaded(List.from(slots)));
      } else if (response.status == 200 &&
          response.data != null &&
          response.data!.isEmpty) {
        slots = [];
        emit(MakeReservationLoaded(List.from(slots)));
      } else {
        final errorMessage = response.error ?? "Error, Try Again Later";
        emit(MakeReservationError(errorMessage));
      }
    }
  }

  Future<void> refreshSlots() async {
    slotsFetched = false; // Reset flag on manual refresh
    await getSlots(true);
  }

  Future<void> searchSlots({String? doctor, String? department}) async {
    emit(MakeReservationProcessLoading(slots));

    // Clean up the filter inputs
    final doctorQuery = doctor?.trim();
    final departmentQuery = department?.trim();

    // If both are empty or null, reload default slots
    final shouldReset = (doctorQuery == null || doctorQuery.isEmpty) &&
        (departmentQuery == null || departmentQuery.isEmpty);

    if (shouldReset) {
      await getSlots(true);
      return;
    }

    // Update filters
    if (doctor != null) doctorFilter = doctor;
    if (department != null) departmentFilter = department;

    String? id = await storage.read(key: "id");
    if (id == null) {
      emit(const MakeReservationError("User ID is missing Error"));
      return;
    }

    response =
        await makeResRepo.filterSlots(id, doctorFilter, departmentFilter);

    if (response.status == 200 && response.data != null) {
      final data = response.data!;
      if (data.isEmpty) {
        emit(MakeReservationSearchFail());
      } else {
        slots = data;
        await updateSlotsUI();
        emit(MakeReservationLoaded(slots));
      }
    } else {
      final errorMessage = response.error ?? "No slots available";
      emit(MakeReservationError(errorMessage));
    }
  }
}
