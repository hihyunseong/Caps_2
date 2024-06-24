import 'dart:convert';
import 'dart:io';

import 'package:caps_2/common/enums/map_status.dart';
import 'package:caps_2/common/utils/extensions.dart';
import 'package:caps_2/map/model/dto/dto_model.dart';
import 'package:caps_2/map/model/request_shared_map/request_shared_map_model.dart';
import 'package:caps_2/map/model/request_shared_map_with_friends/request_shared_map_with_friends_model.dart';
import 'package:caps_2/map/repository/pin_repository.dart';
import 'package:caps_2/map/repository/shared_map_repository.dart';
import 'package:caps_2/models/category.dart';
import 'package:caps_2/models/daily_expense.dart';
import 'package:caps_2/models/expense.dart';
import 'package:caps_2/models/map_model.dart';
import 'package:caps_2/provider/api_service.dart';
import 'package:caps_2/vo/Maps.dart';
import 'package:caps_2/vo/MemberInfo.dart';
import 'package:caps_2/vo/UrlUtil.dart';
import 'package:caps_2/widgets/my_marker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class MapProvider extends ChangeNotifier {
  final _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  SharedMapRepository sharedMapRepository =
      SharedMapRepository(Dio(), baseUrl: '');
  PinRepository pinRepository = PinRepository(Dio(), baseUrl: '');

  late ApiService apiService;
  late Directory _mapDir;

  final String mapUrl = "http://" + UrlUtil.url + ':8082/api/v1/maps';

  String? _loadAccToken;
  String? _loadRefToken;

  String? myIdx;
  String? myEmail;
  String? myName;
  String? myProfile;

  MapProvider() {
    _init();
    initializeHeader();
  }

  Future<void> _initRepository() async {
    const String mapUrl = 'http://43.201.118.1:8082/api/v1/maps';
    const String pinUrl = 'http://43.201.118.1:8083/api/v1/pins';

    const FlutterSecureStorage storage = FlutterSecureStorage();

    String? accToken = await storage.read(key: 'accToken');
    String? refToken = await storage.read(key: 'refToken');

    final Dio dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
      ),
    )..interceptors.addAll(
        <Interceptor>[
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              if (accToken != null && refToken != null) {
                options.headers['Authorization'] = 'Bearer $accToken';
                options.headers['x-refresh-token'] = 'Bearer $refToken';
              }
              return handler.next(options); //continue
            },
          ),
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: true,
            error: true,
            compact: true,
            maxWidth: 90,
          ),
        ],
      );

    sharedMapRepository = SharedMapRepository(dio, baseUrl: mapUrl);
    pinRepository = PinRepository(dio, baseUrl: pinUrl);
  }

  //마이맵 불러오기
  Future<List<Maps>> getMyMap() async {
    final res = await _dio
        .get(
          '$mapUrl/private',
        )
        .catchError((error) => {print(error)});
    print(res);
    return res.data.map((e) => MapModel.fromJson(e)).cast<MapModel>().toList();
  }

  //공유맵 불러오기
  Future<void> getSharedMap() async {
    await _initRepository();
    final maps = await sharedMapRepository.getSharedMap();
    final updatedMaps = [...maps];
    for (int i = 0; i < maps.length; i++) {
      final friends =
          await sharedMapRepository.getSharedMember(mapIdx: maps[i].idx);
      updatedMaps[i] = maps[i].copyWith(
        friends: friends,
      );
    }
    sharedMapList = updatedMaps.map((e) => e.toMapModel()).toList();
    notifyListeners();
  }

  //마이맵 만들기
  Future<void> createMyMap(String title, String color, int lat, int lon) async {
    final res = await _dio.post('$mapUrl/private', data: {
      'title': title,
      'color': color,
      'lat': lat,
      'lon': lon,
    });
    print(res);
  }

  //공유맵 만들기
  Future<void> createSharedMap(
      String title, String color, int lat, int lon) async {
    final res = await _dio.post('$mapUrl/shared', data: {
      'title': title,
      'color': color,
      'lat': lat,
      'lon': lon,
    });
    print(res);
  }

  //지도 멤버 불러오기
  Future<List<MemberInfo>> getMapMembers(int idx) async {
    final res = await _dio
        .get('$mapUrl/members$idx')
        .catchError((error) => {print(error)});
    print(res);
    return res.data
        .map((e) => MemberInfo.fromJson(e))
        .cast<MemberInfo>()
        .toList();
  }

  //만든 지도 멤버 추가하기
  Future<void> addNewMapMembers() async {}

  //기존 지도 멤버 추가하기
  Future<void> addExistMapMember() async {}

  //지도 이름 바꾸기
  Future<void> changeMapInfo() async {}

  //지도 나가기
  Future<void> exitCurrentMap(int idx) async {
    final res =
        await _dio.delete('$mapUrl/$idx').catchError((error) => {print(error)});
    print(res.data);
  }

  Future<void> initializeHeader() async {
    _loadAccToken = await _storage.read(key: 'accToken');
    _loadRefToken = await _storage.read(key: 'refToken');
    myIdx = await _storage.read(key: 'idx');
    myEmail = await _storage.read(key: 'email');
    myName = await _storage.read(key: 'name');
    myProfile = await _storage.read(key: 'profile');

    if (_loadAccToken != null) {
      _dio.options.headers['Authorization'] = 'Bearer $_loadAccToken';
      _dio.options.headers['x-refresh-token'] = 'Bearer $_loadRefToken';
    }
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
      try {
        if (map is File) {
          final mapModel =
              await apiService.loadMapModel(map.path.split('/').last);
          mapModels.add(mapModel!);
        }
      } catch (e) {
        print(e);
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
  List<MapModel> sharedMapList = [];

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
    final MapModel? loadedMapModel;
    if (mapModel.isSharedMap) {
      _expenses.clear();
      final expenseList = await _getExpense(mapModel);
      loadedMapModel = mapModel.copyWith(expenses: expenseList);
    } else {
      final filename = 'map_${mapModel.mapName}.json';
      loadedMapModel = await apiService.loadMapModel(filename);

      print(loadedMapModel);
      print(loadedMapModel?.expenses.length);
      print(loadedMapModel?.expenses);

      // 인덱스 초기화
      _currentIndex = 0;
    }

    if (loadedMapModel != null) {
      _mapModel = loadedMapModel;
      _setExpenses(loadedMapModel.expenses);
      _setMarkers();
      _getPolylines();
    }
  }

  Future<void> deleteMapModel(MapModel mapModel) async {
    if (mapModel.isSharedMap) {
      await sharedMapRepository.deleteSharedMap(mapIdx: mapModel.ownerId);
      await getSharedMap();
    } else {
      await apiService.deleteMapModel(mapModel.mapName);
      _mapList.removeWhere((element) => element.mapName == mapModel.mapName);
    }

    // 현재 사용중인 mapModel 이 삭제되었을 경우
    if (_mapModel?.mapName == mapModel.mapName) {
      _mapModel = null;
      _expenses.clear();
      _markers.clear();
      _polylines.clear();
    }

    notifyListeners();
  }

  Future<void> updateMapModel(
      MapModel beforeMapModel, MapModel afterMapModel) async {
    await apiService.updateMapModel(beforeMapModel, afterMapModel);

    final index = _mapList
        .indexWhere((element) => element.mapName == beforeMapModel.mapName);
    _mapList[index] = afterMapModel;

    notifyListeners();
  }

    Future<void> saveSharedMap(MapModel map) async {
      final parsedDate = map.selectedDate;
      String formattedDate =
          '${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}T${parsedDate.hour.toString().padLeft(2, '0')}:${parsedDate.minute.toString().padLeft(2, '0')}:${parsedDate.second.toString().padLeft(2, '0')}';

      await sharedMapRepository
          .postSharedMap(
            model: RequestSharedMapModel(
              title: map.mapName,
              color: map.color.getColorString(),
              lat: map.latLng!.latitude,
              lon: map.latLng!.longitude,
              selectedDate: formattedDate,
            ),
          )
        .then(
          (value) => {
            sharedMapRepository.postSharedMapWithFriends(
              mapIdx: value.idx,
              model: map.friends
                  .map(
                    (e) => RequestSharedMapWithFriendsModel(
                      mapIdx: value.idx,
                      memberIdx: e.idx,
                    ),
                  )
                  .toList(),
            ),
          },
          onError: (error) => {
            print(
              error,
            ),
          },
        );
  }

  Future<void> _setMarkers() async {
    final List<Marker> myMarkers = [];

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

  Future<List<Expense>> _getExpense(MapModel map) async {
    final pinList = await pinRepository.getAllPin(mapIdx: map.ownerId);
    final List<Expense> expenseList = [];
    for (final pin in pinList) {
      final pinDetail =
          await pinRepository.getPinDetailInfo(pinIdx: pin.pinIdx);
      expenseList.add(
        Expense(
          pinIdx: pin.pinIdx,
          expenseLocationName: pinDetail.header,
          amount: pinDetail.cost.toDouble(),
          category: pinDetail.category.toCategory(),
          content: pinDetail.title,
          memo: pinDetail.memo,
          date: DateTime.now(),
          imagePath: pinDetail.file,
          latitude: pin.lat,
          longitude: pin.lon,
          map: map,
          payMethod: pinDetail.method.toPayMethod(),
          createdAt: DateTime.now(),
          friends: pinDetail.list,
        ),
      );
    }
    return expenseList;
  }

  void addExpense(Expense expense, bool isSharedMap) async {
    if (isSharedMap) {
      final String url =
          'http://43.201.118.1:8083/api/v1/pins/${expense.map.ownerId}';

      var request = http.MultipartRequest('POST', Uri.parse(url));
      const FlutterSecureStorage storage = FlutterSecureStorage();

      String? accToken = await storage.read(key: 'accToken');
      String? refToken = await storage.read(key: 'refToken');

      request.headers['Authorization'] = 'Bearer $accToken';
      request.headers['x-refresh-token'] = 'Bearer $refToken';

      if (expense.imagePath != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'File',
            expense.imagePath!,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }
      final friends = [int.parse(myIdx!)];
      friends.addAll(expense.friends.map((e) => e.idx));
      final dto = DtoModel(
        place: expense.expenseLocationName,
        header: expense.expenseLocationName,
        title: expense.content,
        method: expense.payMethod.toString(),
        category: expense.category.toString(),
        memo: expense.memo,
        cost: expense.amount.toInt(),
        lat: expense.latitude,
        lon: expense.longitude,
        list: friends,
      );

      String jsonString = jsonEncode(dto.toJson());

      var jsonFile = http.MultipartFile.fromString(
        'dto',
        jsonString,
        contentType: MediaType('application', 'json'),
      );

      request.files.add(jsonFile);

      final response = await request.send();
      final httpResponse = await http.Response.fromStream(response);
      // 응답 확인
      if (httpResponse.statusCode == 201) {
        loadMapModel(expense.map);
      } else {
        print('Upload failed.');
      }
    } else {
      _expenses.add(expense);

      // 최근 작성 시간 업데이트
      int mapIndex = _mapList.indexWhere((map) =>
          (map.mapName == expense.map.mapName &&
              map.location == expense.map.location));
      if (mapIndex != -1) {
        _mapList[mapIndex] =
            _mapList[mapIndex].copyWith(lastExpensesUpdate: DateTime.now());
      }
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

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
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

// 카테고리
  final List<Category> _activeCategories = [
    Category.food,
    Category.cafe,
    Category.alcohol,
    Category.photo,
    Category.shopping,
    Category.gift,
  ];

  List<Category> get activeCategories => _activeCategories;

  final List<Category> _hiddenCategories = [
    Category.culture,
    Category.accommodations,
    Category.mart,
    Category.flower,
    Category.medicine,
    Category.tip,
    Category.beauty,
    Category.transport,
    Category.etc,
  ];

  List<Category> get hiddenCategories => _hiddenCategories;

  void showCategory(Category category) {
    _activeCategories.add(category);
    _hiddenCategories.remove(category);

    notifyListeners();
  }

  void hideCategory(Category category) {
    _hiddenCategories.add(category);
    _activeCategories.remove(category);

    notifyListeners();
  }
}
