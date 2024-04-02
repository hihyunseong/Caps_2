import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late GoogleMapController _mapController;
  Position? _currentPosition; 
  Set<Marker> _markers = {}; 
  bool _showPinButton = false; 
  bool _showExpenseButton = false; 
  int _selectedIndex = 0; 

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); 
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
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
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

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  void _onMapTap(LatLng position) {
    if (!_showPinButton) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(position.toString()),
            position: position,
            infoWindow: InfoWindow(
              title: '마커',
              snippet: '위치: ${position.latitude}, ${position.longitude}',
            ),
            onTap: () => _onMarkerTapped(position), 
          ),
        );
        _showPinButton = true; 
        _showExpenseButton = false; 
      });
    }
  }

  void _onMarkerTapped(LatLng position) {
    setState(() {
      _markers.removeWhere((marker) => marker.position == position); 
      _showPinButton = false; 
      _showExpenseButton = false; 
    });
  }

  void _addPin() {
    setState(() {
      _showPinButton = false; 
      _showExpenseButton = true; 
    });
  }

  void _goToCurrentLocation() {
    if (_currentPosition != null && _mapController != null) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated, 
            initialCameraPosition: _currentPosition != null
                ? CameraPosition(
                    target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                    zoom: 15,
                  )
                : CameraPosition(
                    target: LatLng(37.006547, 127.226156), 
                    zoom: 15,
                  ), 
            myLocationEnabled: true, 
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false, 
            onTap: _onMapTap, 
            markers: _markers, 
          ),
          if (_showPinButton) 
            Positioned(
              bottom: 32.0,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: _addPin, 
                  icon: Image.asset(
                    'assets/pin.png', 
                    width: 24.0, 
                    height: 24.0, 
                  ),
                  label: Text(
                    '여기에 핀 꽂기',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), 
                    fixedSize: MaterialStateProperty.all<Size>(Size(200.0, 50.0)),
                  ),
                ),
              ),
            ),
          if (_showExpenseButton) 
            Positioned(
              bottom: 32.0,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {}, 
                  icon: Icon(Icons.account_balance_wallet), 
                  label: Text(
                    '가계부',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.orange), 
                    fixedSize: MaterialStateProperty.all<Size>(Size(200.0, 50.0)),
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
              shape: CircleBorder(),
              child: IconButton(
                onPressed: () {}, 
                icon: Icon(Icons.settings, color: Colors.black, size: 28.0), 
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
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
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(Icons.my_location, color: Colors.black, size: 28.0), 
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
