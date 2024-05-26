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
  State<MapPlus> createState() => _MapPlusState();
}

class _MapPlusState extends State<MapPlus> {
  String mapName = '';
  List<String> friends = [];
  Prediction? selectedLocation;
  Color? selectedColor;
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
  void dispose() {
    _friendController.dispose();
    _locationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Align(
        alignment: FractionalOffset(0.4, 0),
        child: Text('맵 추가'),
      )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text.rich(
                TextSpan(
                  text: '맵 이름',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Container(
                    width: 360,
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
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        hintText: '맵 이름',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFC4C4C4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text.rich(
                TextSpan(
                  text: '맵 색상 선택',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                _colorTile(Color(0xFF61AAFF)),
                _colorTile(Color(0xFFB961FF)),
                _colorTile(Color(0xFF36AE92)),
                _colorTile(Colors.orangeAccent),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Container(
                    width: 56.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey, width: 1.0),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Color(0xFFFF6F61),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            // if (widget.isSharedMap)
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '친구 추가',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Container(
                    width: 360,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: _friendController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        hintText: '초대할 친구 이름을 검색해 주세요.',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFC4C4C4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text.rich(
                TextSpan(
                  text: '지역 선택',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  // LocationSearchField(),
                  Container(
                    width: 360,
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
                        hintText: '지도가 시작될 지역을 선택해 주세요',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFC4C4C4),
                        ),
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

            const SizedBox(height: 150),
            Center(
              child: SizedBox(
                child: ElevatedButton(
                  onPressed: () => _registerMap(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 100.0,
                    ),
                    textStyle: const TextStyle(fontSize: 18.0),
                    backgroundColor: const Color(0xFFFF6F61),
                  ),
                  child:
                      const Text('완료', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _registerMap() {
    // 현재는 friend textfield에 글자가 있는 경우 배열에 넣어줘서 처리
    if (_friendController.text != '') {
      friends.add(_friendController.text);
    }

    if (selectedLocation == null) {
      // 지역이 선택되지 않은 경우, 에러 메시지를 띄워줍니다.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('지역을 선택해주세요.'),
        ),
      );
      return;
    }

    if (selectedColor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('색상을 선택해주세요.'),
        ),
      );
      return;
    }

    final newMap = MapModel(
      mapName: mapName,
      friends: friends,
      location: selectedLocation!,
      selectedDate: selectedDate,
      expenses: [],
      color: selectedColor!,
    );

    final mapProvider = context.read<MapProvider>();
    mapProvider.addMapModel(newMap);

    Navigator.of(context).pop(newMap);
  }

  Widget _colorTile(Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: GestureDetector(
        onTap: () {
          selectedColor = color;
        },
        child: Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
