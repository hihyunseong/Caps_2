import 'package:caps_2/expense/model/comment_model.dart';
import 'package:caps_2/map/model/pin/pin_model.dart';
import 'package:caps_2/map/model/request_comment/request_comment_model.dart';
import 'package:caps_2/map/model/request_pin/request_pin_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'pin_repository.g.dart';

@RestApi()
abstract class PinRepository {
  factory PinRepository(
    Dio dio, {
    String baseUrl,
  }) = _PinRepository;

  @PUT('/{mapIdx}/{pinIdx}')
  Future<PinModel> editPin({
    @Path('mapIdx') required int mapIdx,
    @Path('pinIdx') required int pinIdx,
    @Body() required RequestPinModel model,
  });

  @POST('/{pinIdx}/post')
  Future<CommentModel> postComment({
    @Path('pinIdx') required int pinIdx,
    @Body() required RequestCommentModel model,
  });

  @POST('/{mapIdx}')
  Future<PinModel> postPin({
    @Path('mapIdx') required int mapIdx,
    @Body() required RequestPinModel model,
  });

  @GET('/{pinIdx}')
  Future<PinModel> getPinInfo({
    @Path('pinIdx') required int pinIdx,
  });

  @DELETE('/{pinIdx}')
  Future<void> deletePin({
    @Path('pinIdx') required int pinIdx,
  });

  @GET('/{pinIdx}/comments')
  Future<List<CommentModel>> getComments({
    @Path('pinIdx') required int pinIdx,
  });
}
