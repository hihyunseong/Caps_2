import 'package:caps_2/common/utils/extensions.dart';
import 'package:caps_2/friend/model/friend_model.dart';
import 'package:caps_2/models/map_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_places_flutter/model/prediction.dart';

part 'shared_map.freezed.dart';

part 'shared_map.g.dart';

@freezed
class SharedMap with _$SharedMap {
  const SharedMap._();

  const factory SharedMap({
    required int idx,
    required int ownerIdx,
    required String title,
    required String color,
    required double lat,
    required double lon,
    required List<int> pins,
    required DateTime selectedDate,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<FriendModel> friends,
  }) = _SharedMap;

  MapModel toMapModel() {
    return MapModel(
      mapName: title,
      ownerId: idx,
      sharedOwnerId: ownerIdx,
      friends: friends,
      location: Prediction(
        lat: lat.toString(),
        lng: lon.toString(),
      ),
      selectedDate: selectedDate,
      expenses: [],
      isSharedMap: true,
      lastExpensesUpdate: updatedAt,
      color: color.getColorFromString(),
    );
  }

  MapModel toMyMapModel() {
    return MapModel(
      mapName: title,
      ownerId: idx,
      friends: friends,
      location: Prediction(
        lat: lat.toString(),
        lng: lon.toString(),
      ),
      selectedDate: selectedDate,
      expenses: [],
      isSharedMap: false,
      lastExpensesUpdate: updatedAt,
      color: color.getColorFromString(),
    );
  }

  factory SharedMap.fromJson(Map<String, dynamic> json) =>
      _$SharedMapFromJson(json);
}