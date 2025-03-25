import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/core/networking/api_service.dart';
import 'package:cloud_medix/features/make_reservation/data/hospital_slot.dart';

class ReservationRepository {
  Future<ApiResponse<List<HospitalSlot>>> getSlots() async {
    ApiService client = getIt<ApiService>();
    var response = await client.getallSlots();
    return response;
  }
}
