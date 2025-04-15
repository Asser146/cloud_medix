import 'package:cloud_medix/core/networking/api_constants.dart';
import 'package:cloud_medix/core/networking/api_response.dart';
import 'package:cloud_medix/features/auth/data/login_body.dart';
import 'package:cloud_medix/features/auth/data/register_body.dart';
import 'package:cloud_medix/features/make_reservation/data/slot.dart';
import 'package:cloud_medix/features/medical_record/data/medical_record.dart';
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

  @GET(ApiConstants.slots)
  Future<ApiResponse<List<Slot>>> getallSlots();

  @GET("${ApiConstants.medicalRecord}/{id}")
  Future<ApiResponse<MedicalRecord>> getMedicalRecord(@Path('id') String id);
}
