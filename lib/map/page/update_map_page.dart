import 'package:caps_2/add_expense/widget/custom_button.dart';
import 'package:caps_2/friend/model/friend_model.dart';
import 'package:caps_2/friend/provider/friend_provider.dart';
import 'package:caps_2/friend/widget/friend_text_field.dart';
import 'package:caps_2/models/map_model.dart';
import 'package:caps_2/provider/map_provider.dart';
import 'package:caps_2/widgets/sub_title_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:provider/provider.dart';

class UpdateMapPage extends StatefulWidget {
  final MapModel mapModel;

  const UpdateMapPage({
    super.key,
    required this.mapModel,
  });

  @override
  State<UpdateMapPage> createState() => _UpdateMapPageState();
}

class _UpdateMapPageState extends State<UpdateMapPage> {
  // 맵 이름
  final TextEditingController _mapNameController = TextEditingController();
  // 친구 초대
  final TextEditingController _friendSearchController = TextEditingController();
  // 지역 선택
  final TextEditingController _locationController = TextEditingController();
  // 친구 찾기
  final ValueNotifier<String> _searchText = ValueNotifier<String>("");
  Color? selectedColor;
  List<FriendModel> selectedFriends = [];
  Prediction? selectedLocation;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _friendSearchController.addListener(() {
      _searchText.value = _friendSearchController.text;
    });
    setState(() {
      _mapNameController.text = widget.mapModel.mapName;
      selectedColor = widget.mapModel.color;
      selectedLocation = widget.mapModel.location;
      selectedFriends = List.from(widget.mapModel.friends);
      selectedLocation = widget.mapModel.location;
      _locationController.text = selectedLocation?.description ?? '';
    });
  }

  @override
  void dispose() {
    _mapNameController.dispose();
    _friendSearchController.dispose();
    _searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final friendProvider = context.watch<FriendProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.mapModel.isSharedMap ? '공유맵 편집' : '마이맵 편집',
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'NanumSquareNeo-Bold',
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  SubTitleWidget(subTitle: '맵 이름', isRequired: true),
                  const SizedBox(height: 10.0),
                  _titleInputWidget(),
                  const SizedBox(height: 20.0),
                  SubTitleWidget(subTitle: '맵 색상 선택', isRequired: true),
                  const SizedBox(height: 10.0),
                  _colorSelectWidget(),
                  const SizedBox(height: 20.0),
                  if (widget.mapModel.isSharedMap) ...[
                    SubTitleWidget(subTitle: '친구 초대', isRequired: true),
                    const SizedBox(height: 10.0),
                    _friendInviteWidget(friendProvider),
                    const SizedBox(height: 20.0),
                  ],
                  SubTitleWidget(subTitle: '지역 선택', isRequired: true),
                  const SizedBox(height: 10.0),
                  _locationSelectWidget(),
                  const SizedBox(height: 100.0),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                title: '완료',
                onTap: () {
                  _updateMap();
                },
                height: 70,
                color:
                    _isReadyToRegister() ? Colors.red[300]! : Colors.red[100]!,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _titleInputWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: TextField(
            controller: _mapNameController,
            onChanged: (value) {
              setState(() {});
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(
                left: 20,
                top: 15,
                bottom: 15,
              ),
              hintText: '맵 이름을 입력해 주세요.',
              hintStyle: TextStyle(
                color: Color(0xFFC4C4C4),
                fontFamily: 'NanumSquareNeo-Bold',
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color(0xFFC4C4C4),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _colorSelectWidget() {
    return Row(
      children: [
        _colorTile(const Color.fromRGBO(47, 200, 84, 1)),
        const SizedBox(width: 15),
        _colorTile(const Color.fromRGBO(255, 185, 55, 1)),
        const SizedBox(width: 15),
        _colorTile(const Color.fromRGBO(124, 88, 175, 1)),
        const SizedBox(width: 15),
        _colorTile(const Color.fromRGBO(58, 91, 172, 1)),
      ],
    );
  }

  Widget _colorTile(Color color) {
    bool isSelected = selectedColor == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
          border:
              isSelected ? Border.all(color: Colors.black, width: 2.5) : null,
        ),
      ),
    );
  }

  Widget _friendInviteWidget(FriendProvider friendProvider) {
    return Column(
      children: [
        Row(
          children: selectedFriends.map((friend) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Stack(
                children: [
                  (friend.profile != null)
                      ? Image.network(
                          friend.profile!,
                          height: 45,
                          width: 45,
                        )
                      : const Icon(
                          Icons.person,
                          size: 70,
                        ),
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFriends.remove(friend);
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        FriendTextField(
          controller: _friendSearchController,
          hintText: '맵을 함께 만들 친구를 검색해보세요.',
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder<String>(
          valueListenable: _searchText,
          builder: (context, searchText, child) {
            final filteredFriendList =
                friendProvider.friendList.where((friend) {
              return friend.name.contains(searchText);
            }).toList();
            return Column(
              children: filteredFriendList.map((friend) {
                bool isSelected = selectedFriends.contains(friend);
                return ListTile(
                  leading: (friend.profile != null)
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(friend.profile!),
                        )
                      : const Icon(Icons.person),
                  title: Text(friend.name),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: Colors.red)
                      : const Icon(Icons.radio_button_unchecked),
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedFriends.remove(friend);
                      } else {
                        selectedFriends.add(friend);
                      }
                    });
                  },
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _locationSelectWidget() {
    return GooglePlaceAutoCompleteTextField(
      // focusNode: FocusNode(),
      textEditingController: _locationController,
      googleAPIKey: 'AIzaSyBS7vyfFibnUZye3oVPwzBaEL4lw7S5iaI',
      // countries: ['KR'],
      boxDecoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
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
        setState(() {
          _locationController.text = prediction.description ?? '';
          selectedLocation = prediction as Prediction?;
        });
      },
      showError: false,
    );
  }

  bool _isReadyToRegister() {
    // 공유맵
    if (widget.mapModel.isSharedMap) {
      if (_mapNameController.text.isEmpty ||
          selectedColor == null ||
          selectedLocation == null ||
          selectedFriends.isEmpty) {
        return false;
      }
    } else {
      // 마이맵
      if (_mapNameController.text.isEmpty ||
          selectedColor == null ||
          selectedLocation == null) {
        return false;
      }
    }
    return true;
  }

  void _updateMap() async {
    if (_mapNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('맵 이름을 입력해주세요.'),
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
    if (widget.mapModel.isSharedMap) {
      if (selectedFriends.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('친구를 초대해주세요.'),
          ),
        );
        return;
      }
    }

    if (selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('지역을 선택해주세요.'),
        ),
      );
      return;
    }
    final mapProvider = context.read<MapProvider>();

    if (widget.mapModel.isSharedMap) {
      await mapProvider.editSharedMap(widget.mapModel.copyWith(
        mapName: _mapNameController.text,
        friends: selectedFriends,
        location: selectedLocation!,
        color: selectedColor!,
      ));
    } else {
      final storage = const FlutterSecureStorage();

      final newMap = MapModel(
        mapName: _mapNameController.text,
 
        ownerId: widget.mapModel.ownerId,

        friends: selectedFriends,
        location: selectedLocation!,
        selectedDate: selectedDate,
        expenses: [],
        color: selectedColor!,
        isSharedMap: widget.mapModel.isSharedMap,
      );

      await mapProvider.updateMapModel(widget.mapModel, newMap);
      mapProvider.forceNotify();
    }

    Navigator.of(context).pop();
  }
}
