import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_comment_model.freezed.dart';
part 'post_comment_model.g.dart';

@freezed
class PostCommentModel with _$PostCommentModel {
  factory PostCommentModel({
    required String content,
  }) = _PostCommentModel;

  factory PostCommentModel.fromJson(Map<String, dynamic> json) =>
      _$PostCommentModelFromJson(json);
}
