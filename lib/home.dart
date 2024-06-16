import 'dart:io';

import 'package:caps_2/common/enums/map_status.dart';
import 'package:caps_2/friend/provider/friend_provider.dart';
import 'package:caps_2/map/page/update_my_map_list_page.dart';
import 'package:caps_2/map/page/update_share_map_list_page.dart';
import 'package:caps_2/models/category.dart';
import 'package:caps_2/models/daily_expense.dart';
import 'package:caps_2/models/map_model.dart';
import 'package:caps_2/widgets/daily_expense_panel.dart';
import 'package:caps_2/widgets/expense_details_panel.dart';
import 'package:caps_2/widgets/map_details_panel.dart';
import 'package:caps_2/widgets/expenses_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:widget_to_marker/widget_to_marker.dart';
import 'provider/map_provider.dart';
import 'widgets/map_tile.dart';
import 'widgets/my_marker.dart';
import 'my/page/my_page.dart';
import 'add_expense/page/expense_amount_page.dart';
import 'map_plus.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late GoogleMapController _mapController;
  late Position _currentPosition;

  LatLng get _currentLatLng => LatLng(
        _currentPosition.latitude,
        _currentPosition.longitude,
      );

  bool _showPinButton = true;
  bool _showExpenseButton = false;
  int _selectedIndex = 0;
  DateTime _selectedDate = DateTime.now();

  bool isBottomBarVisible = false;
  bool isHomeSelected = false;
  bool isMySelected = false;
  bool isMyMapSelected = false;
  bool isShareMapSelected = false;

  final _mainPanelController = PanelController();

  @override
  void dispose() {
    _mapController.dispose();

    super.dispose();
  }

  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return null;
      }
    }

    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _currentPosition = position;

    return position;
  }

  Marker _createMarker(double lat, double lng) {
    return Marker(
      markerId: const MarkerId('current_location'),
      position: LatLng(lat, lng),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  void _onMapTap(LatLng position) {
    if (_showPinButton) {}
  }

  void _onMarkerTapped(LatLng position) {
    setState(() {});
  }

  Future<void> _addPin(LatLng pinLocation) async {
    final markers = context.read<MapProvider>().markers;
    final expenses = context.read<MapProvider>().expenses;

    final marker = Marker(
        markerId: MarkerId('marker_id_${markers.length}'),
        position: LatLng(
          pinLocation.latitude,
          pinLocation.longitude,
        ),
        onTap: () => _onMarkerTapped(
              LatLng(
                pinLocation.latitude,
                pinLocation.longitude,
              ),
            ),
        icon: await MyMarker(
          index: markers.length + 1,
          category:
              expenses.isNotEmpty ? expenses.last.category : Category.plus,
          // icon: expenses.isNotEmpty
          //     ? expenses.last.category.icon
          //     : Icons.account_balance_wallet,
          imagePath: expenses.isNotEmpty ? expenses.last.imagePath : null,
        ).toBitmapDescriptor(
          logicalSize: const Size(400, 400),
        ));

    _addMarker(marker);
  }

  Future<void> _addMarker(Marker marker) async {
    final mapProvider = context.read<MapProvider>();
    await mapProvider.addMarker(marker);
  }

  void _goToCurrentLocation() {
    if (_currentPosition != null) {
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target:
                LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            zoom: 19,
          ),
        ),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // 홈
        break;
      case 1:
        // 마이맵
        _mainPanelController.open();
        break;
      case 2:
        // 공유맵
        _mainPanelController.open();
        break;
      case 3:
        // MY
        _mainPanelController.open();
        break;
    }
  }

  void _showDatePickerDialog() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }

  void _decreaseDate() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
    });
  }

  void _increaseDate() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        panel: _mainPanel(),
        controller: _mainPanelController,
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        minHeight: 150,
        maxHeight: MediaQuery.of(context).size.height * 0.85,
        body: _mapScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedLabelStyle: TextStyle(fontFamily: "NanumSquareNeo-Bold"),
        unselectedLabelStyle: TextStyle(fontFamily: "NanumSquareNeo-Bold"),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: const Color(0xFFFF6F61),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/home/home1.png',
            ),
            activeIcon: Image.asset(
              'assets/images/home/home2.png',
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/mymap/mymap1.png',
            ),
            activeIcon: Image.asset(
              'assets/images/mymap/mymap2.png',
            ),
            label: '마이맵',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/sharemap/sharemap1.png',
            ),
            activeIcon: Image.asset(
              'assets/images/sharemap/sharemap2.png',
            ),
            label: '공유맵',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/user/user1.png',
            ),
            activeIcon: Image.asset(
              'assets/images/user/user2.png',
            ),
            label: 'MY',
          ),
        ],
      ),
      extendBody: true,
    );
  }

  Widget _mainPanel() {
    final MapProvider mapProvider = context.watch<MapProvider>();

    return IndexedStack(
      index: _selectedIndex,
      children: [
        _homePanel(),
        switch (mapProvider.myMapStatus) {
          MapStatus.mapList => _myMapPanel(),
          MapStatus.expenses => ExpensesPanel(
              panelController: _mainPanelController,
              googleMapController: _mapController,
            ),
          MapStatus.dailyExpense => DailyExpensePanel(),
          MapStatus.mapDetails => const MapDetailsPanel(),
          MapStatus.expenseDetails => const ExpenseDetailsPanel(),
          MapStatus() => throw UnimplementedError(),
        },
        switch (mapProvider.shareMapStatus) {
          MapStatus.mapList => _sharedMapPanel(),
          MapStatus.expenses => ExpensesPanel(
              panelController: _mainPanelController,
              googleMapController: _mapController,
            ),
          MapStatus.dailyExpense => DailyExpensePanel(),
          MapStatus.mapDetails => const MapDetailsPanel(),
          MapStatus.expenseDetails => const ExpenseDetailsPanel(),
          MapStatus() => throw UnimplementedError(),
        },
        const MyPage(),
      ],
    );
  }

  Widget _homePanel() {
    final mapProvider = context.watch<MapProvider>();
    final currentIndex = mapProvider.currentIndex;

    final DailyExpense? dailyExpense = mapProvider.dailyExpenses.isEmpty
        ? null
        : mapProvider.dailyExpenses[currentIndex];

    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFC4C4C4),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: mapProvider.currentIndex == 0
                    ? null
                    : () {
                        final LatLng? latLng = mapProvider.decrementIndex();
                        if (dailyExpense != null && latLng != null) {
                          _gotoMapPosition(latLng);
                        }
                      },
                icon: const Icon(Icons.arrow_back),
              ),
              TextButton(
                onPressed: null,
                child: Text(
                  dailyExpense == null
                      ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                      : DateFormat('yyyy-MM-dd').format(dailyExpense.tourDay),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: mapProvider.currentIndex ==
                        mapProvider.dailyExpenses.length - 1
                    ? null
                    : () {
                        final LatLng? latLng = mapProvider.incrementIndex();
                        if (dailyExpense != null && latLng != null) {
                          _gotoMapPosition(latLng);
                        }
                      },
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          ),

          // 가계부 데이터
          if (dailyExpense != null)
            Expanded(
              child: ListView.builder(
                itemCount: dailyExpense.expenses.length,
                itemBuilder: (context, index) {
                  final expense = dailyExpense.expenses[index];
                  
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          child: Image.asset(
                            expense.category.iconPath,
                            width: 24,
                            height: 24,
                          ),
                          // child: Icon(expense.category.icon),
                        ),
                        title: Text(
                          expense.content,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          expense.memo,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          '${expense.amount.toInt()} 원',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      expense.imagePath != null
                          ? Image.file(
                              File(expense.imagePath!),
                              width: 100,
                              height: 100,
                            )
                          : const SizedBox.shrink(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

  Widget _myMapPanel() {
    final mapProvider = context.watch<MapProvider>();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '마이맵',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'NanumSquareNeo-Bold',
            ),
          ),
          Text(
            '나만의 소비를 기록해 보세요!', 
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'NanumSquareNeo-Bold',
              color: Color(0xFF9D9D9D),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UpdateMyMapListPage()),
              );
            },
            child: Text(
              '편집',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'NanumSquareNeo-Bold',
                color: Color(0xFFFF6F61),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                '맵 목록',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'NanumSquareNeo-Bold',
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${mapProvider.myMapList.length}',
                style: const TextStyle(
                  color: Color(0xFFFF6F61),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              FloatingActionButton(
                heroTag: 'my_map',
                onPressed: () => _registerMyMap(),
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: const Icon(Icons.add, color: Color(0xFFFF6F61)),
              ),
            ],
          ),
          mapProvider.myMapList.isEmpty
              ? const Expanded(
                  child: Center(
                  child: Text(
                    '아직 작성한 지도가 없습니다.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ))
              : Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: mapProvider.myMapList.length,
                    itemBuilder: (context, index) {
                      final mapModel = mapProvider.myMapList[index];

                      return MapTile(
                        mapModel: mapModel,
                        gotoLocation: (LatLng? latLng) =>
                            _gotoMapPosition(latLng),
                        changeDate: (date) {
                          _selectedDate = date;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

  Widget _sharedMapPanel() {
    final mapProvider = context.watch<MapProvider>();
    final frinedProvider = context.read<FriendProvider>();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '공유맵',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'NanumSquareNeo-Bold',
            ),
          ),
          Text(
            '친구들과 함께 소비를 기록해 보세요!', 
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'NanumSquareNeo-Bold',
              color: Color(0xFF9D9D9D),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UpdateShareMapListPage()),
              );
            },
            child: Text(
              '편집',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'NanumSquareNeo-Bold',
                color: Color(0xFFFF6F61),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                '맵 목록',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'NanumSquareNeo-Bold',
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${mapProvider.sharedMapList.length}',
                style: const TextStyle(
                  color: Color(0xFFFF6F61),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              FloatingActionButton(
                heroTag: 'shared_map',
                onPressed: () => {
                  frinedProvider.getLatestList(),
                  _registerMyMap(
                    isSharedMap: true,
                  ),
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: const Icon(Icons.add, color: Color(0xFFFF6F61)),
              ),
            ],
          ),
          mapProvider.sharedMapList.isEmpty
              ? const Expanded(
                  child: Center(
                  child: Text(
                    '아직 작성한 지도가 없습니다.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ))
              : Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: mapProvider.sharedMapList.length,
                    itemBuilder: (context, index) {
                      final mapModel = mapProvider.sharedMapList[index];

                      return MapTile(
                        mapModel: mapModel,
                        gotoLocation: (LatLng? latLng) =>
                            _gotoMapPosition(latLng),
                        changeDate: (date) {
                          _selectedDate = date;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

  Widget _myPagePanel() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFC4C4C4),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('마이페이지'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mapScreen() {
    var screenWidth = MediaQuery.of(context).size.width * 0.5;
    var screenHeight = MediaQuery.of(context).size.height * 0.1;

    return Stack(
      alignment: Alignment.center,
      children: [
        FutureBuilder<Position?>(
          future: _getCurrentLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final Position? position = snapshot.data;

              final markers = context.watch<MapProvider>().markers;
              final polylines = context.watch<MapProvider>().polylines;

              return GoogleMap(
                onMapCreated: (controller) => _onMapCreated(controller),
                initialCameraPosition: position != null
                    ? CameraPosition(
                        target: LatLng(
                          position.latitude,
                          position.longitude,
                        ),
                        zoom: 17,
                      )
                    : const CameraPosition(
                        target: LatLng(31.43, 127.269311),
                        zoom: 17,
                      ),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                onTap: _onMapTap,
                markers: Set<Marker>.of(markers),
                polylines: Set<Polyline>.of(polylines),
                onCameraMove: (position) {},
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),

        if (_showPinButton)
          Positioned(
            bottom: 180.0,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // setState(() {
                  //   _showExpenseButton = true;
                  // });
                  _addExpense();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFFF6F61)),
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(200.0, 52.0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/logo2.png', width: 27, height: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '여기에 핀 콕 꽂기',
                      style: TextStyle(fontFamily: "", fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        // if (_showExpenseButton)
        //   Positioned(
        //     bottom: 180.0,
        //     left: 0,
        //     right: 0,
        //     child: Center(
        //       child: ElevatedButton.icon(
        //         onPressed: () async {},
        //         icon: const Icon(Icons.account_balance_wallet),
        //         label: const Text(
        //           '가계부',
        //           style: TextStyle(fontSize: 14.0, color: Colors.white),
        //         ),
        //         style: ButtonStyle(
        //           backgroundColor:
        //               MaterialStateProperty.all<Color>(Colors.orange),
        //           fixedSize:
        //               MaterialStateProperty.all<Size>(const Size(150.0, 50.0)),
        //         ),
        //       ),
        //     ),
        //   ),
        Positioned(
          bottom: 180.0,
          right: 16.0,
          child: InkWell(
            onTap: _goToCurrentLocation,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/loc/Outline/Navigation/Current-location.png',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),

        Positioned(
          left: 21.0,
          top: 50.0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 2),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '소비를 기록할 장소를 검색해보세요.',
                      hintStyle: TextStyle(color: Color(0xFFC4C4C4)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Image.asset(
                  'assets/images/search/Iconly/Regular/Light/Search.png',
                  width: 24,
                  height: 24,
                ),
              ],
            ),
          ),
        ),

        // 고정 핀 이미지
        Positioned(
          top: MediaQuery.of(context).size.height * 0.5 - 70,
          child: Image.asset('assets/images/location_pin.png',
              width: 50, height: 50),
        ),
      ],
    );
  }

  Future<void> _addExpense() async {
    // 포지션 정보 확인
    // 지도의 가운데 위치 구하기
    final size = MediaQuery.of(context).size;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    final double screenWidth = size.width * devicePixelRatio;
    final double screenHeight = size.height * devicePixelRatio;

    final double middleX = screenWidth / 2;
    final double middleY = screenHeight / 2;

    final pinLocation = await _mapController.getLatLng(
      ScreenCoordinate(x: middleX.round(), y: middleY.round()),
    );

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseAmountPage(
          location: pinLocation,
          date: _selectedDate,
        ),
      ),
    );

    // 지출 입력시에만 핀을 꽂는다. (book2 에서 true 입력)
    if (result == true) {
      await _addPin(pinLocation);
    }

    setState(() {
      _showExpenseButton = false;
      _showPinButton = true;
    });
  }

  Future<void> _registerMyMap({
    bool isSharedMap = false,
  }) async {
    final newMap = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapPlus(
          isSharedMap: isSharedMap,
        ),
      ),
    );

    if (newMap != null) {
      _changeMapModel(newMap as MapModel);

      await _gotoMapPosition(newMap.latLng);
    }
  }

  void _changeMapModel(MapModel mapModel) {
    final mapProvider = context.read<MapProvider>();
    mapProvider.changeMapModel(mapModel);
    mapProvider.saveMapModel();

    // 날짜변경
    setState(() {
      _selectedDate = mapModel.selectedDate;
    });
  }

  Future<void> _gotoMapPosition(LatLng? latLng) async {
    await _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng ?? _currentLatLng,
          zoom: 17,
        ),
      ),
    );
  }
}
