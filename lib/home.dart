import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:widget_to_marker/widget_to_marker.dart';
import 'models/expense.dart';
import 'widgets/my_marker.dart';
import 'my.dart';
import 'book.dart';
import 'home_setting.dart';
import 'map_plus.dart';
import 'map/my_map.dart';
import 'map/share_map.dart';

final List<Expense> expenses = [];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

bool isBottomBarVisible = false;

class _HomeState extends State<Home> {
  late GoogleMapController _mapController;
  Position? _currentPosition;
  final List<Marker> _markers = [];
  bool _showPinButton = true;
  bool _showExpenseButton = false;
  int _selectedIndex = 0;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    _getCurrentLocation();
  }

  @override
  void dispose() {
    _mapController.dispose();

    super.dispose();
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = position;
    });
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
    final marker = Marker(
        markerId: MarkerId('marker_id_${_markers.length}'),
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
          index: _markers.length + 1,
          icon: expenses.isNotEmpty
              ? expenses.last.category.icon
              : Icons.account_balance_wallet,
        ).toBitmapDescriptor());

    setState(() {
      _markers.add(marker);
    });
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
        panel: _slidingPanel(),
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        minHeight: 140,
        body: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              onMapCreated: (controller) => _onMapCreated(controller),
              initialCameraPosition: _currentPosition != null
                  ? CameraPosition(
                      target: LatLng(_currentPosition!.latitude,
                          _currentPosition!.longitude),
                      zoom: 17,
                    )
                  : const CameraPosition(
                      target: LatLng(37.006547, 127.226156),
                      zoom: 17,
                    ),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              onTap: _onMapTap,
              markers: Set<Marker>.of(_markers),
              onCameraMove: (position) {},
            ),
            if (_showPinButton)
              Positioned(
                bottom: 160.0,
                left: 0,
                right: 0,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showExpenseButton = true;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      fixedSize:
                          MaterialStateProperty.all<Size>(Size(150.0, 50.0)),
                    ),
                    child: const Text(
                      '여기에 핀 꽂기',
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
            if (_showExpenseButton)
              Positioned(
                bottom: 160.0,
                left: 0,
                right: 0,
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      // 포지션 정보 확인
                      // 지도의 가운데 위치 구하기
                      final size = MediaQuery.of(context).size;
                      final devicePixelRatio =
                          MediaQuery.of(context).devicePixelRatio;

                      final double screenWidth = size.width * devicePixelRatio;
                      final double screenHeight =
                          size.height * devicePixelRatio;

                      final double middleX = screenWidth / 2;
                      final double middleY = screenHeight / 2;

                      final pinLocation = await _mapController.getLatLng(
                        ScreenCoordinate(
                            x: middleX.round(), y: middleY.round()),
                      );

                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Book()),
                      );

                      await _addPin(pinLocation);

                      setState(() {
                        _showExpenseButton = false;
                        _showPinButton = true;
                      });
                    },
                    icon: const Icon(Icons.account_balance_wallet),
                    label: const Text(
                      '가계부',
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                      fixedSize: MaterialStateProperty.all<Size>(
                          const Size(150.0, 50.0)),
                    ),
                  ),
                ),
              ),
            Positioned(
              top: 16.0,
              right: 16.0,
              child: Material(
                elevation: 0,
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeSetting()),
                    );
                  },
                  icon: const Icon(Icons.settings,
                      color: Colors.black, size: 28.0),
                ),
              ),
            ),
            Positioned(
              bottom: 160.0,
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
                  child: const Icon(Icons.my_location,
                      color: Colors.black, size: 28.0),
                ),
              ),
            ),
            Positioned(
              left: 16.0,
              top: 16.0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '검색',
                          border: InputBorder.none,
                        ),
                      ),
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
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 60,
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.home),
                  ),
                ),

                /// 나의 맵 하단바
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        _showSlidingPanel(context);
                        setState(() {
                          isBottomBarVisible = !isBottomBarVisible;
                        });
                      },
                      child: Icon(Icons.map, color: Colors.black),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        elevation: MaterialStateProperty.all<double>(0),
                      ),
                    ),
                  ),
                ),

                /// 공유맵 하단바
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        _showSlidingPanel2(context);
                        setState(() {
                          isBottomBarVisible = !isBottomBarVisible;
                        });
                      },
                      child: Icon(Icons.circle, color: Colors.black),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        elevation: MaterialStateProperty.all<double>(0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyPage()),
                      );
                    },
                    icon: const Icon(Icons.person),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      extendBody: true,
    );
  }

  Widget _slidingPanel() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: _decreaseDate,
                icon: const Icon(Icons.arrow_back),
              ),
              TextButton(
                onPressed: _showDatePickerDialog,
                child: Text(
                  '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                ),
              ),
              IconButton(
                onPressed: _increaseDate,
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          ),

          // 가계부 데이터
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];

                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: Icon(expense.category.icon),
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
}

/// 나의 맵 하단바
void _showSlidingPanel(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => SlidingUpPanel(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      minHeight: 1500,
      maxHeight: MediaQuery.of(context).size.height * 0.7,
      panel: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '나의맵',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyMap()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '기본맵',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// 공유맵 하단바
void _showSlidingPanel2(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => Scaffold(
      backgroundColor: Colors.transparent,
      body: SlidingUpPanel(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        minHeight: 1500,
        maxHeight: MediaQuery.of(context).size.height * 0.7,
        panel: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '공유맵',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Center(
                child: Text(
                  '친구들과 함께 지도를 작성해보세요!',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(height: 20), // 새로 추가된 부분
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShareMap()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '기본맵',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MapPlus()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    ),
  );
}
