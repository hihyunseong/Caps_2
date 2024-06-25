part of 'post_comment_bloc.dart';

@freezed
class PostCommentState with _$PostCommentState {
  const factory PostCommentState.initial() = _Initial;
  const factory PostCommentState.progress() = _Progress;
  const factory PostCommentState.success() = _Success;
  const factory PostCommentState.failure({
    String? errorMessage,
  }) = _Failure;
}
