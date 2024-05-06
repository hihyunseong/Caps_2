import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:caps_2/home.dart';


class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  GoogleMapController? mapController;
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildMapWidget(),
          _buildBackButton(context), 
        ],
      ),
    );
  }

  Widget _buildMapWidget() {
    return _currentLocation == null
      ? Center(child: CircularProgressIndicator())
      : GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _currentLocation!, // 초기 지도 실시간 위치
            zoom: 19.0,
          ),
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
        );
      }

      Widget _buildBackButton(BuildContext context) {
      return Positioned(
        top: 16,
        left: 16,
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Home()),
          );
        },
      ),
    );
  }
}
