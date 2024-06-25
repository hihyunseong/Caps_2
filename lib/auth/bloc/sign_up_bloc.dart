import 'package:bloc/bloc.dart';
import 'package:caps_2/auth/model/sign_up_model.dart';
import 'package:caps_2/auth/model/sign_up_result_model.dart';
import 'package:caps_2/auth/repository/sign_up_repository.dart';
import 'package:caps_2/common/utils/service_injector.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_bloc.freezed.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState.initial()) {
    on<SignUpEvent>(
      (event, emit) async {
        await event.map(
          started: (event) async {
            try {
              final SignUpResultModel result = await _signUpRepository.signUp(
                signUpData: SignUpModel(
                  email: event.email,
                  password: event.password,
                  username: event.userName,
                  phone: event.phone,
                ),
              );

              emit(
                SignUpState.success(
                  signUpResultModel: result,
                ),
              );
            } catch (e) {
              // 회원가입 실패
              emit(
                SignUpState.failure(message: e.toString()),
              );
              debugPrint(e.toString());
            }
          },
        );
      },
    );
  }

  final SignUpRepository _signUpRepository = ServiceInjector.injector();
}
