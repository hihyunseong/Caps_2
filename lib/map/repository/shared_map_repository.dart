import 'package:caps_2/friend/model/friend_model.dart';
import 'package:caps_2/map/model/request_map_title/request_map_title_model.dart';
import 'package:caps_2/map/model/request_shared_map/request_shared_map_model.dart';
import 'package:caps_2/map/model/request_shared_map_with_friends/request_shared_map_with_friends_model.dart';
import 'package:caps_2/map/model/shared_map/shared_map.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'shared_map_repository.g.dart';

@RestApi()
abstract class SharedMapRepository {
  factory SharedMapRepository(
    Dio dio, {
    String baseUrl,
  }) = _SharedMapRepository;

  @GET('/shared')
  Future<List<SharedMap>> getSharedMap();

  @GET('/members/{mapIdx}')
  Future<List<FriendModel>> getSharedMember({
    @Path('mapIdx') required int mapIdx,
  });

  @POST('/shared')
  Future<SharedMap> postSharedMap({
    @Body() required RequestSharedMapModel model,
  });

  @POST('/members/{mapIdx}')
  Future<void> postSharedMapWithFriends({
    @Path('mapIdx') required int mapIdx,
    @Body() required List<RequestSharedMapWithFriendsModel> model,
  });

  @PUT('/title/{mapIdx}')
  Future<SharedMap> putSharedMapTitle({
    @Path('mapIdx') required int mapIdx,
    @Body() required RequestMapTitleModel model,
  });

  @POST('/adds')
  Future<void> postFriendToMap({
    @Body() required RequestSharedMapWithFriendsModel model,
  });

  @DELETE('/{mapIdx}')
  Future<void> deleteSharedMap({
    @Path('mapIdx') required int mapIdx,
  });
}
