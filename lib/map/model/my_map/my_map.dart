import 'package:caps_2/common/utils/extensions.dart';
import 'package:caps_2/friend/model/friend_model.dart';
import 'package:caps_2/models/map_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_places_flutter/model/prediction.dart';

part 'my_map.freezed.dart';
part 'my_map.g.dart';

@freezed
class MyMap with _$MyMap {
  const MyMap._();

  const factory MyMap({
    required int idx,
    required String title,
    required String color,
    required double lat,
    required double lon,
    required List<int> pins,
    required DateTime selectedDate,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<FriendModel> friends,
  }) = _MyMap;

  MapModel toMapModel() {
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

  factory MyMap.fromJson(Map<String, dynamic> json) => _$MyMapFromJson(json);
}
