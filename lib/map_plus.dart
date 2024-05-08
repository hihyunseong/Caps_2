import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'models/map_model.dart';
import 'provider/map_provider.dart';

class MapPlus extends StatefulWidget {
  final bool isSharedMap;

  const MapPlus({
    super.key,
    this.isSharedMap = false,
  });

  @override
  _MapPlusState createState() => _MapPlusState();
}

class _MapPlusState extends State<MapPlus> {
  String mapName = '';
  List<String> friends = [];
  Prediction? selectedLocation;
  DateTime selectedDate = DateTime.now();
  final TextEditingController _friendController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _navigateToMapPlus(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapPlus()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: null,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 20.0),
                Text(
                  '맵 추가',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                '친구들과 함께 \n지도를 추가해보세요!',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                '맵정보',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text(
                    '맵이름',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          mapName = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            if (widget.isSharedMap)
              Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Row(
                  children: [
                    Text(
                      '친구\n추가',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _friendController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                '지역선택',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                '지도가 시작될 지역을 선택해주세요',
                style: TextStyle(fontSize: 12.0),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 35.0),
              child: Row(
                children: [
                  Text(
                    '지역',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(width: 10),
                  // LocationSearchField(),
                  Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: GooglePlaceAutoCompleteTextField(
                      // focusNode: FocusNode(),
                      textEditingController: _locationController,
                      googleAPIKey: 'AIzaSyBS7vyfFibnUZye3oVPwzBaEL4lw7S5iaI',
                      // countries: ['KR'],
                      boxDecoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      inputDecoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      itemClick: (prediction) {
                        _locationController.text = prediction.description ?? '';
                        selectedLocation = prediction as Prediction?;
                      },
                      showError: false,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 37.0),
              child: Row(
                children: [
                  Text(
                    '날짜',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 5),
                        Text(
                          DateFormat('yyyy-MM-dd')
                              .format(selectedDate), // 선택된 날짜를 텍스트로 표시합니다.
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 80),
            Center(
              child: SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (_friendController.text != '') {
                      friends.add(_friendController.text);
                    }

                    if (selectedLocation != null) {
                      final newMap = MapModel(
                        mapName: mapName,
                        friends: friends,
                        location: selectedLocation!,
                        selectedDate: selectedDate,
                        expenses: [],
                      );

                      context.read<MapProvider>().addMapModel(newMap);

                      // if (friends.isEmpty) {
                      //   친구 없는 경우
                      //   context.read<MapProvider>().addMyMapList(newMap);
                      // } else {
                      //   친구 있는 경우
                      //   context.read<MapProvider>().addSharedMapList(newMap);
                      // }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 100.0,
                    ),
                    textStyle: TextStyle(fontSize: 18.0),
                  ),
                  child: Text('등록하기'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
