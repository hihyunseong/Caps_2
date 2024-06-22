import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_comment_model.freezed.dart';

part 'request_comment_model.g.dart';

@freezed
class RequestCommentModel with _$RequestCommentModel {
  const factory RequestCommentModel({
    required String content,
  }) = _RequestCommentModel;

  factory RequestCommentModel.fromJson(Map<String, dynamic> json) =>
      _$RequestCommentModelFromJson(json);
}
