import 'package:caps_2/auth/model/sign_up_model.dart';
import 'package:caps_2/auth/model/sign_up_result_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'sign_up_repository.g.dart';

@RestApi()
abstract class SignUpRepository {
  factory SignUpRepository(
    Dio dio, {
    String baseUrl,
  }) = _SignUpRepository;

  @POST('/register')
  Future<SignUpResultModel> signUp({
    @Body() required SignUpModel signUpData,
  });
}
