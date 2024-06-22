part of 'sign_up_bloc.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState.initial() = _Initial;
  const factory SignUpState.progress() = _Progress;
  const factory SignUpState.success({
    required SignUpResultModel signUpResultModel,
  }) = _Success;
  const factory SignUpState.failure({
    String? message,
  }) = _Failure;
}
