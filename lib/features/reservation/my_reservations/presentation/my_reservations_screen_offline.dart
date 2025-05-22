import 'dart:convert';
import 'dart:developer';

import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/theming/styles.dart';
import 'package:cloud_medix/core/widgets/empty_state_widget.dart';
import 'package:cloud_medix/core/widgets/loading_widget.dart';
import 'package:cloud_medix/core/widgets/my_app_bar.dart';
import 'package:cloud_medix/features/reservation/make_reservation/data/slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyReservationsScreenOffline extends StatefulWidget {
  const MyReservationsScreenOffline({super.key});

  @override
  State<MyReservationsScreenOffline> createState() =>
      _MyReservationsScreenOfflineState();
}

class _MyReservationsScreenOfflineState
    extends State<MyReservationsScreenOffline> {
  final storage = const FlutterSecureStorage();
  List<Slot> slots = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadOfflineReservations();
  }

  Future<void> loadOfflineReservations() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = await storage.read(key: "id");

    if (userId == null) {
      setState(() {
        isLoading = false;
        slots = [];
      });
      return;
    }

    final String key = "hospital_slot_map";
    final rawMap = prefs.getString(key);
    if (rawMap == null) {
      setState(() {
        isLoading = false;
        slots = [];
      });
      return;
    }

    final decoded = jsonDecode(rawMap) as Map<String, dynamic>;
    final userMap = decoded[userId] as Map<String, dynamic>?;

    if (userMap == null) {
      setState(() {
        isLoading = false;
        slots = [];
      });
      return;
    }

    final List<Slot> allUserSlots = [];

    for (var hospitalEntry in userMap.entries) {
      final slotJsonList = List<Map<String, dynamic>>.from(hospitalEntry.value);
      final hospitalSlots =
          slotJsonList.map((json) => Slot.fromJson(json)).toList();
      allUserSlots.addAll(hospitalSlots);
    }

    setState(() {
      slots = allUserSlots;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "My Reservations"),
      backgroundColor: ColorsManager.backgroundColor,
      body: isLoading
          ? const Center(child: LoadingWidget())
          : slots.isEmpty
              ? const Center(
                  child: EmptyStateWidget(message: "No Reservations found"))
              : ListView.builder(
                  padding: EdgeInsets.all(10.w),
                  itemCount: slots.length,
                  itemBuilder: (context, index) {
                    final slot = slots[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 70.h,
                            width: 8.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.r),
                                bottomLeft: Radius.circular(12.r),
                              ),
                              color: ColorsManager.darkgreyColor,
                            ),
                          ),
                          Container(
                            height: 75.h,
                            width: 0.8 * MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.r),
                                bottomRight: Radius.circular(10.r),
                              ),
                              color: ColorsManager.lightgreyColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${DateFormat.Hm().format(slot.startTime)} - ${DateFormat.Hm().format(slot.endTime)}",
                                    style: TextStyles.slotDuration,
                                  ),
                                  Text(slot.physicianFullName,
                                      style: TextStyles.doctorName),
                                  Text("Specialty: ${slot.specialtyName}",
                                      style: TextStyles.hospitalName),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
