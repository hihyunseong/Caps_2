import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'my.dart';
import 'book.dart';
import 'map.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late GoogleMapController _mapController;
  Position? _currentPosition;
  Marker? _marker;
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
      _marker = _createMarker(position.latitude, position.longitude);
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
    if (_showPinButton) {
      // Add your logic here
    }
  }

  void _onMarkerTapped(LatLng position) {
    setState(() {
      _marker = null;
      _showPinButton = true;
      _showExpenseButton = false;
    });
  }

  void _addPin() {
    setState(() {
    _showExpenseButton = true;
  });
}

  void _goToCurrentLocation() {
    if (_currentPosition != null) {
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            zoom: 18,
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
      _selectedDate = _selectedDate.subtract(Duration(days: 1));
    });
  }

  void _increaseDate() {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => _onMapCreated(controller),
            initialCameraPosition: _currentPosition != null
                ? CameraPosition(
                    target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                    zoom: 15,
                  )
                : const CameraPosition(
                    target: LatLng(37.006547, 127.226156),
                    zoom: 15,
                  ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onTap: _onMapTap,
            markers: _marker != null ? Set<Marker>.from([_marker!]) : {},
            onCameraMove: (position) {
              if (_marker != null) {
                setState(() {
                  _marker = _marker!.copyWith(
                    positionParam: position.target,
                  );
                });
              }
            },
          ),
          if (_showPinButton)
            Positioned(
              bottom: 120.0,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: _addPin,
                  child: const Text(
                    '여기에 핀 꽂기',
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    fixedSize:
                        MaterialStateProperty.all<Size>(Size(150.0, 50.0)),
                  ),
                ),
              ),
            ),
          if (_showExpenseButton)
            Positioned(
              bottom: 120.0,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Book()),
                    );
                  },
                  icon: const Icon(Icons.account_balance_wallet),
                  label: const Text(
                    '가계부',
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.orange),
                    fixedSize:
                        MaterialStateProperty.all<Size>(Size(150.0, 50.0)),
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
                onPressed: () {},
                icon:
                    const Icon(Icons.settings, color: Colors.black, size: 28.0),
              ),
            ),
          ),
          Positioned(
            bottom: 120.0,
            right: 16.0,
            child: InkWell(
              onTap: _goToCurrentLocation,
              child: Container(
                padding: EdgeInsets.all(12.0),
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
              width: MediaQuery.of(context).size.width * 0.85,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
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
        ],
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          height: 60,
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.home),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapPage()),
                    );
                  },
                  icon: const Icon(Icons.map),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyPage()),
                    );
                  },
                  icon: const Icon(Icons.person),
                ),
              ],
            ),
          ),
        ),
      ),
      extendBody: true,
      bottomSheet: Row(
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
    );
  }
}