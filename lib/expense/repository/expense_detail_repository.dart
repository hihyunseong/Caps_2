import 'package:caps_2/expense/model/comment_model.dart';
import 'package:caps_2/expense/model/post_comment_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'expense_detail_repository.g.dart';

@RestApi()
abstract class ExpenseDetailRepository {
  factory ExpenseDetailRepository(
    Dio dio, {
    String baseUrl,
  }) = _ExpenseDetailRepository;

  /// 댓글 불러오기
  @GET('/{pinIdx}/comments')
  Future<List<CommentModel>> getComments({
    @Path() required int pinIdx,
  });

  /// 댓글 쓰기
  @POST('/{pinIdx}/post')
  Future<void> postComment({
    @Path() required int pinIdx,
    @Body() required PostCommentModel postCommentModel,
  });

  /// 지도에 있는 특정 핀의 자세한 정보 불러오기
  @GET('/detail/{pinIdx}')
  Future<String> getExpenseDetail({
    @Path() required int pinIdx,
  });
}
