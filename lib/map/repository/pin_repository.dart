import 'dart:convert';
import 'dart:io';

import 'package:caps_2/expense/model/comment_model.dart';
import 'package:caps_2/map/model/dto/dto_model.dart';
import 'package:caps_2/map/model/pin/pin_detail_model.dart';
import 'package:caps_2/map/model/pin/pin_model.dart';
import 'package:caps_2/map/model/request_comment/request_comment_model.dart';
import 'package:caps_2/map/model/request_pin/request_pin_model.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
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
  @MultiPart()
  Future<PinModel> postPin({
    @Path('mapIdx') required int mapIdx,
    @Part(contentType: "image/jpeg") File? File,
    @Part(contentType: "application/json", name: 'dto') required DtoModel dto,
  });

  @GET('/list/{mapIdx}')
  Future<List<PinModel>> getAllPin({
    @Path('mapIdx') required int mapIdx,
  });

  @GET('/{pinIdx}')
  Future<PinModel> getPinInfo({
    @Path('pinIdx') required int pinIdx,
  });

  @GET('/detail/{pinIdx}')
  Future<PinDetailModel> getPinDetailInfo({
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
