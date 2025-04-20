import 'package:cloud_medix/core/networking/api_constants.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/features/auth/data/login_body.dart';
import 'package:cloud_medix/features/auth/data/register_body.dart';
import 'package:cloud_medix/features/reservation/make_reservation/data/reservation_body.dart';
import 'package:cloud_medix/features/reservation/make_reservation/data/slot.dart';
import 'package:cloud_medix/features/medical_record/data/medical_record.dart';
import 'package:cloud_medix/features/reservation/my_reservations/data/my_reservation.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) {
    return _ApiService(dio, baseUrl: baseUrl ?? ApiConstants.apiBaseUrl);
  }

  @POST(ApiConstants.register)
  Future<ApiResponse> register(
    @Body() RegisterBody registerRequestBody,
  );

  @POST(ApiConstants.login)
  Future<ApiResponse<List<String>>> login(
    @Body() LoginBody loginRequestBody,
  );

  @GET("${ApiConstants.slots}/{id}")
  Future<ApiResponse<List<Slot>>> getallSlots(@Path('id') String id);

  @GET("${ApiConstants.myReservations}/{id}")
  Future<ApiResponse<List<MyReservation>>> getMyReservations(
      @Path('id') String id);

  @GET("${ApiConstants.medicalRecord}/{id}")
  Future<ApiResponse<MedicalRecord>> getMedicalRecord(@Path('id') String id);

  @POST("${ApiConstants.makeReservation}/{id}")
  Future<ApiResponse> makeReservation(
    @Path('id') String id,
    @Body() ReservationBody reservationRequestBody,
  );

  @DELETE("${ApiConstants.cancelReservation}/{patientId}/{id}")
  Future<ApiResponse<String>> cancelReservation(
    @Path("patientId") String patientId,
    @Path("id") int reservationId,
  );
}
