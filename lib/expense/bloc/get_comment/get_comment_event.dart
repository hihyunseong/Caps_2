part of 'get_comment_bloc.dart';

@freezed
class GetCommentEvent with _$GetCommentEvent {
  const factory GetCommentEvent.started({
    required int pinIdx,
  }) = _Started;
}
