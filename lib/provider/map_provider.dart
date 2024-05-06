import 'dart:convert';
import 'dart:io';

import 'package:caps_2/models/expense.dart';
import 'package:caps_2/models/map_model.dart';
import 'package:caps_2/widgets/my_marker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart' as p;
import 'package:widget_to_marker/widget_to_marker.dart';

class MapProvider extends ChangeNotifier {
  late Directory _appDir;

  MapProvider() {
    _init();
  }

  Future<void> _init() async {
    _appDir = await getApplicationDocumentsDirectory();

    // load all map models
    final mapDir = Directory(p.join(_appDir.path, 'maps'));

    if (!await mapDir.exists()) {
      await mapDir.create();
    }

    final List<MapModel> mapModels = [];

    final mapFiles = await mapDir.list().toList();
    for (final map in mapFiles) {
      if (map is File) {
        final mapModel = await loadMapModel(map.path.split('/').last);
        mapModels.add(mapModel!);
      }
    }

    _mapList.clear();
    _mapList.addAll(mapModels);
  }

  // map list 통합
  final List<MapModel> _mapList = [];
  List<MapModel> get mapList => _mapList;

  void addMapModel(MapModel map) {
    _mapList.add(map);
    notifyListeners();
  }

  List<MapModel> get myMapList =>
      mapList.where((element) => element.friends.isEmpty).toList();
  List<MapModel> get sharedMapList =>
      mapList.where((element) => element.friends.isNotEmpty).toList();

  // marker
  final List<Marker> _markers = [];
  List<Marker> get markers => _markers;

  Future<void> addMarker(Marker marker) async {
    _markers.add(marker);

    await saveMapModel();

    _getPolylines();

    notifyListeners();
  }

  Future<void> loadMarkers() async {
    final List<Marker> myMarkers = [];

    for (var i = 0; i < expenses.length; i++) {
      final expense = expenses[i];

      final marker = Marker(
          markerId: MarkerId('marker_id_$i'),
          position: LatLng(
            expense.latitude,
            expense.longitude,
          ),
          onTap: () {},
          icon: await MyMarker(
            index: i + 1,
            icon: expense.category.icon,
            imagePath: expense.imagePath,
          ).toBitmapDescriptor());

      myMarkers.add(marker);
    }

    _markers.clear();
    _markers.addAll(myMarkers);

    _getPolylines();

    notifyListeners();
  }

  // polilyne
  final List<Polyline> _polylines = [];
  List<Polyline> get polylines => _polylines;

  void _getPolylines() {
    final List<LatLng> points = [];

    for (final expense in expenses) {
      points.add(LatLng(expense.latitude, expense.longitude));
    }

    final polyline = Polyline(
      polylineId: const PolylineId('polyline_id'),
      points: points,
      color: Colors.blue[300]!,
      width: 15,
    );

    _polylines.clear();
    _polylines.add(polyline);
  }

  // expense
  final List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;

  void addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  void changeExpenses(MapModel mapModel) {
    final expenses = mapModel.expenses;

    _expenses.clear();
    _expenses.addAll(expenses);
  }

  // map model
  MapModel? _mapModel;
  MapModel? get mapModel => _mapModel;

  void setMapModel(MapModel mapModel) {
    _mapModel = mapModel;
  }

  // save map model
  Future<void> saveMapModel() async {
    // 지출내역을 추가하여 저장
    final updatedMapModel = _mapModel!.copyWith(
      expenses: _expenses,
    );

    final mapDir = Directory(p.join(_appDir.path, 'maps'));

    final filename = 'map_${updatedMapModel.mapName}.json';
    final file = File(p.join(mapDir.path, filename));

    final Map<String, dynamic> mapModelJson = updatedMapModel.toJson();
    await file.writeAsString(jsonEncode(mapModelJson));
  }

  // load map model
  Future<MapModel?> loadMapModel(String filename) async {
    final mapDir = Directory(p.join(_appDir.path, 'maps'));

    final file = File(p.join(mapDir.path, filename));

    if (file.existsSync()) {
      final mapModelJson = jsonDecode(await file.readAsString());
      return MapModel.fromJson(mapModelJson);
    }

    return null;
  }

  // delete map model from local storage
  Future<void> deleteMapModel(String mapName) async {
    final mapDir = Directory(p.join(_appDir.path, 'maps'));

    final filename = 'map_$mapName.json';
    final file = File(p.join(mapDir.path, filename));

    await file.delete();

    _mapList.removeWhere((element) => element.mapName == mapName);

    notifyListeners();
  }
}
