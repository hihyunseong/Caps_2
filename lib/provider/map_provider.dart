import 'dart:io';

import 'package:caps_2/enums/map_status.dart';
import 'package:caps_2/models/daily_expense.dart';
import 'package:caps_2/models/expense.dart';
import 'package:caps_2/models/map_model.dart';
import 'package:caps_2/provider/api_service.dart';
import 'package:caps_2/widgets/my_marker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:widget_to_marker/widget_to_marker.dart';

import 'package:path/path.dart' as p;

class MapProvider extends ChangeNotifier {
  late ApiService apiService;

  late Directory _mapDir;

  MapProvider() {
    _init();
  }

  Future<void> _init() async {
    // load all map models
    final appDir = await getApplicationDocumentsDirectory();
    _mapDir = Directory(p.join(appDir.path, 'maps'));

    if (!_mapDir.existsSync()) {
      await _mapDir.create();
    }
    apiService = ApiService(mapDirPath: _mapDir.path);

    await _loadAllMap();
  }

  Future<void> _loadAllMap() async {
    final List<MapModel> mapModels = [];

    final mapFiles = await _mapDir.list().toList();

    for (final map in mapFiles) {
      if (map is File) {
        final mapModel =
            await apiService.loadMapModel(map.path.split('/').last);
        mapModels.add(mapModel!);
      }
    }

    _mapList.clear();
    _mapList.addAll(mapModels);
  }

  // *******************************************
  // 맵 목록 (나의 맵 + 공유맵)/
  // *******************************************

  final List<MapModel> _mapList = [];
  List<MapModel> get mapList => _mapList;

  void addMapModel(MapModel map) {
    _mapList.add(map);
    notifyListeners();
  }

  // 나의 맵
  List<MapModel> get myMapList =>
      mapList.where((element) => !element.isSharedMap).toList();

  // 공유 맵
  List<MapModel> get sharedMapList =>
      mapList.where((element) => element.isSharedMap).toList();

  // marker
  final List<Marker> _markers = [];
  List<Marker> get markers => _markers;

  Future<void> addMarker(Marker marker) async {
    // map 이 선택되어 있을때만 저장햐야 함
    if (_mapModel != null) {
      await saveMapModel();
    }

    _setMarkers();
    _getPolylines();

    notifyListeners();
  }

  Future<void> saveMapModel() async {
    // 지출내역을 업데이트 하여 저장
    final updatedMapModel = _mapModel!.copyWith(
      expenses: _expenses,
    );
    await apiService.saveMapModel(
      mapModel: updatedMapModel,
    );
  }

  Future<void> loadMapModel(MapModel mapModel) async {
    final filename = 'map_${mapModel.mapName}.json';
    final loadedMapModel = await apiService.loadMapModel(filename);

    // 인덱스 초기화
    _currentIndex = 0;

    if (loadedMapModel != null) {
      _mapModel = loadedMapModel;
      _setExpenses(loadedMapModel.expenses);
      _setMarkers();
      _getPolylines();
    }
  }

  Future<void> deleteMapModel(MapModel mapModel) async {
    await apiService.deleteMapModel(mapModel.mapName);
    _mapList.removeWhere((element) => element.mapName == mapModel.mapName);

    // 현재 사용중인 mapModel 이 삭제되었을 경우
    if (_mapModel?.mapName == mapModel.mapName) {
      _mapModel = null;
      _expenses.clear();
      _markers.clear();
      _polylines.clear();
    }

    notifyListeners();
  }

  Future<void> _setMarkers() async {
    final List<Marker> myMarkers = [];
    print(tourExpenses);
    for (var i = 0; i < tourExpenses.length; i++) {
      final expense = tourExpenses[i];

      final marker = Marker(
          markerId: MarkerId('marker_id_$i'),
          position: LatLng(
            expense.latitude,
            expense.longitude,
          ),
          onTap: () {},
          icon: await MyMarker(
            index: i + 1,
            category: expense.category,
            imagePath: expense.imagePath,
          ).toBitmapDescriptor(
            logicalSize: const Size(400, 400),
          ));

      myMarkers.add(marker);
    }

    _markers.clear();
    _markers.addAll(myMarkers);

    notifyListeners();
  }

  // polilyne
  final List<Polyline> _polylines = [];
  List<Polyline> get polylines => _polylines;

  void _getPolylines() {
    final List<LatLng> points = [];

    for (final expense in tourExpenses) {
      points.add(LatLng(expense.latitude, expense.longitude));
    }

    final polyline = Polyline(
      polylineId: const PolylineId('polyline_id'),
      points: points,
      color: Color(0xD9FF6F61),
      width: 7,
    );

    _polylines.clear();
    _polylines.add(polyline);
  }

  // expense
  final List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;

  void addExpense(Expense expense) {
    _expenses.add(expense);

    // 최근 작성 시간 업데이트
    int mapIndex = _mapList.indexWhere((map) =>
        (map.mapName == expense.map.mapName &&
            map.location == expense.map.location));
    if (mapIndex != -1) {
      _mapList[mapIndex] =
          _mapList[mapIndex].copyWith(lastExpensesUpdate: DateTime.now());
    }

    notifyListeners();
  }

  void _setExpenses(List<Expense> expenses) {
    _expenses.clear();
    _expenses.addAll(expenses);
  }

  List<Expense> get tourExpenses =>
      dailyExpenses.isEmpty ? [] : dailyExpenses[_currentIndex].expenses;



  // 지출을 날짜별로 그룹핑
  List<DailyExpense> get dailyExpenses {

    final Map<DateTime, List<Expense>> grouped = {};

    for (final expense in expenses) {
      final key = expense.tourDay;

      if (grouped.containsKey(key)) {
        grouped[key]!.add(expense);
      } else {
        grouped[key] = [expense];
      }
    }

    final List<DailyExpense> dailyExpenses = [];

    grouped.forEach((key, value) {
      dailyExpenses.add(DailyExpense(expenses: value));
    });

    // 날짜별로 정렬
    dailyExpenses.sort((a, b) => a.tourDay.compareTo(b.tourDay));

    return dailyExpenses;
  }

  // 날짜 눌렀을 때 해당 날짜에 해당하는 소비 기록을 설정해주는 함수
  Future<void> setIndexForDate(DateTime dateTime) async {
    final index = dailyExpenses.indexWhere((dailyExpense) {
      final expenseDate = dailyExpense.expenses.first.date;
      return expenseDate.year == dateTime.year &&
          expenseDate.month == dateTime.month &&
          expenseDate.day == dateTime.day;
    });

    if (index != -1) {
      _currentIndex = index;
      await _updateMarker(); // 마커 업데이트를 기다림
    }

    notifyListeners();
  }

  // 모든 마커가 보이도록 지도를 축소하는 메서드
  Future<void> fitAllMarkers(GoogleMapController mapController) async {
    if (_markers.isEmpty) return;

    LatLngBounds bounds = _calculateBounds(_markers);

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 250);
    await mapController.animateCamera(cameraUpdate);
  }

  LatLngBounds _calculateBounds(List<Marker> markers) {
    double southWestLat = markers.first.position.latitude;
    double southWestLng = markers.first.position.longitude;
    double northEastLat = markers.first.position.latitude;
    double northEastLng = markers.first.position.longitude;

    for (Marker marker in markers) {
      if (marker.position.latitude < southWestLat)
        southWestLat = marker.position.latitude;
      if (marker.position.longitude < southWestLng)
        southWestLng = marker.position.longitude;
      if (marker.position.latitude > northEastLat)
        northEastLat = marker.position.latitude;
      if (marker.position.longitude > northEastLng)
        northEastLng = marker.position.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(southWestLat, southWestLng),
      northeast: LatLng(northEastLat, northEastLng),
    );
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  LatLng? incrementIndex() {
    // ddailyExpenses.length 보다 커지지 않도록
    if (_currentIndex < dailyExpenses.length - 1) {
      _currentIndex++;

      _updateMarker();
    }

    notifyListeners();

    final LatLng? latLng =
        tourExpenses.isEmpty ? null : tourExpenses.first.latLng;
    return latLng;
  }

  LatLng? decrementIndex() {
    // 0 보다 작아지지 않도록
    if (_currentIndex > 0) {
      _currentIndex--;
      _updateMarker();
    }

    notifyListeners();

    final LatLng? latLng =
        tourExpenses.isEmpty ? null : tourExpenses.first.latLng;
    return latLng;
  }

  // MapModel - 현재 선택된 MapModel을 의미
  MapModel? _mapModel;
  MapModel? get mapModel => _mapModel;

  void changeMapModel(MapModel mapModel) {
    _currentIndex = 0;
    _mapModel = mapModel;
    _setExpenses(mapModel.expenses);
    _setMarkers();
    _getPolylines();

    notifyListeners();
  }

  Future<void> _updateMarker() async {
    await _setMarkers();
    _getPolylines();
  }

  // MapStatus - 어떤 panel 을 보여줄지 확인하는 용도로 쓰임
  MapStatus _myMapStatus = MapStatus.mapList;
  MapStatus get myMapStatus => _myMapStatus;

  void changeMyMapStatus(MapStatus status) {
    _myMapStatus = status;
    _shareMapStatus = MapStatus.mapList;

    notifyListeners();
  }

  MapStatus _shareMapStatus = MapStatus.mapList;
  MapStatus get shareMapStatus => _shareMapStatus;

  void changeShareMapStatus(MapStatus status) {
    _myMapStatus = MapStatus.mapList;
    _shareMapStatus = status;
    notifyListeners();
  }

  // daily Expense - 그날 사용한 expense list
  DailyExpense? _dailyExpense;
  DailyExpense? get dailyExpense => _dailyExpense;

  void setDailyExpense(DailyExpense dailyExpense) {
    _dailyExpense = dailyExpense;
    _updateMarker();
    notifyListeners();
  }

  // expense - 단일
  Expense? _expense;
  Expense? get expense => _expense;

  void setExpense(Expense expense) {
    _expense = expense;
    notifyListeners();
  }
}
