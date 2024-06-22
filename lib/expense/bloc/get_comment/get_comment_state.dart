part of 'get_comment_bloc.dart';

@freezed
class GetCommentState with _$GetCommentState {
  const factory GetCommentState.initial() = _Initial;
  const factory GetCommentState.progress() = _Progress;
  const factory GetCommentState.success({
    required List<CommentModel> comments,
  }) = _Success;
  const factory GetCommentState.failure({
    String? errMessage,
  }) = _Failure;
}
