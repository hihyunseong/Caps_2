part of 'post_comment_bloc.dart';

@freezed
class PostCommentEvent with _$PostCommentEvent {
  const factory PostCommentEvent.started({
    required int pinIdx,
    required String content,
  }) = _Started;
}
