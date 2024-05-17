import 'dart:convert';
import 'dart:io';

import 'package:caps_2/models/map_model.dart';

import 'package:path/path.dart' as p;

class ApiService {
  final String mapDirPath;

  ApiService({
    required this.mapDirPath,
  });

  // save map model to local storage
  Future<void> saveMapModel({
    required MapModel mapModel,
  }) async {
    final filename = 'map_${mapModel.mapName}.json';
    final file = File(p.join(mapDirPath, filename));

    final Map<String, dynamic> mapModelJson = mapModel.toJson();
    await file.writeAsString(jsonEncode(mapModelJson));
  }

  // load map model from local storage
  Future<MapModel?> loadMapModel(String filename) async {
    final file = File(p.join(mapDirPath, filename));

    if (file.existsSync()) {
      final mapModelJson = jsonDecode(await file.readAsString());
      return MapModel.fromJson(mapModelJson);
    }

    return null;
  }

  // delete map model from local storage
  Future<void> deleteMapModel(String mapName) async {
    final filename = 'map_$mapName.json';
    final file = File(p.join(mapDirPath, filename));

    if (file.existsSync()) {
      await file.delete();
    }
  }
}
