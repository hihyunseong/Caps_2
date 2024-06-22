import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_result_model.freezed.dart';
part 'sign_up_result_model.g.dart';

@freezed
class SignUpResultModel with _$SignUpResultModel {
  factory SignUpResultModel({
    required int idx,
    required String email,
    required String name,
    required String profile,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SignUpResultModel;

  factory SignUpResultModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpResultModelFromJson(json);
}
