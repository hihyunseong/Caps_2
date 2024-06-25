part of 'sign_up_bloc.dart';

@freezed
class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.started({
    required String email,
    required String password,
    required String userName,
    required String phone,
  }) = _Started;
}
