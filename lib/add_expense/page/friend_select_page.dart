import 'package:caps_2/add_expense/page/expense_detail_page.dart';
import 'package:caps_2/add_expense/widget/custom_button.dart';
import 'package:caps_2/friend/model/friend_model.dart';
import 'package:caps_2/models/map_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FriendSelectPage extends StatefulWidget {
  final double amount;
  final LatLng location;
  final DateTime date;
  final String expenseLocationName;
  final MapModel mapModel;

  const FriendSelectPage({
    super.key,
    required this.amount,
    required this.location,
    required this.date,
    required this.expenseLocationName,
    required this.mapModel,
  });

  @override
  State<FriendSelectPage> createState() => _FriendSelectPageState();
}

class _FriendSelectPageState extends State<FriendSelectPage> {
  final _friendSearchController = TextEditingController();
  // 친구 찾기
  final ValueNotifier<String> _searchText = ValueNotifier<String>("");

  final List<FriendModel> selectedFriends = [];

  String? myProfileImage;

  @override
  void initState() {
    super.initState();
    _friendSearchController.addListener(() {
      _searchText.value = _friendSearchController.text;
    });
    getMyProfileImage();
  }

  @override
  void dispose() {
    _friendSearchController.dispose();
    super.dispose();
  }

  void getMyProfileImage() async {
    const storage = FlutterSecureStorage();
    final tmp = await storage.read(key: 'profile');
    setState(() {
      myProfileImage = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '함께한 멤버 선택',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'NanumSquareNeo-Bold',
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                if (selectedFriends.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  _selectedFriendList(),
                ],
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: _friendSearchController,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'NanumSquareNeo-Bold',
                      color: Colors.grey[400]!,
                    ),
                    decoration: InputDecoration(
                      hintText: '함께한 멤버를 검색해 보세요',
                      suffixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(
                          color: Colors.grey[400]!,
                          width: 1.5,
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(left: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      '${widget.mapModel.mapName} 멤버',
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'NanumSquareNeo-Bold',
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.people_alt,
                      color: Colors.purple,
                      size: 20,
                    ),
                    Text(
                      '${widget.mapModel.friends.length + 1}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'NanumSquareNeo-Bold',
                        color: Colors.purple,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                _friendList(),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                title: '다음',
                height: 70,
                color: Colors.red,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExpenseDetailPage(
                        amount: widget.amount,
                        location: widget.location,
                        date: widget.date,
                        expenseLocationName: widget.expenseLocationName,
                        mapModel: widget.mapModel,
                        selectedFriends: selectedFriends,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _selectedFriendList() {
    return Row(
      children: selectedFriends.map((friend) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Stack(
            children: [
              (friend.profile != null)
                  ? Image.network(
                      friend.profile!,
                      height: 70,
                      width: 70,
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
    );
  }

  Widget _friendList() {
    return ValueListenableBuilder<String>(
      valueListenable: _searchText,
      builder: (context, searchText, child) {
        final filteredFriendList = widget.mapModel.friends.where((friend) {
          return friend.name.contains(searchText);
        }).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _myListTile(),
            ...filteredFriendList.map((friend) {
              bool isSelected = selectedFriends.contains(friend);
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: (friend.profile != null)
                    ? Image.network(
                        friend.profile!,
                        height: 50,
                        width: 50,
                      )
                    : const Icon(
                        Icons.person,
                        size: 50,
                      ),
                title: Text(
                  friend.name,
                  style: const TextStyle(
                    fontFamily: 'NanumSquareNeo-Bold',
                  ),
                ),
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
          ],
        );
      },
    );
  }

  Widget _myListTile() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: (myProfileImage != null)
          ? Image.network(
              myProfileImage!,
              height: 50,
              width: 50,
            )
          : const Icon(
              Icons.person,
              size: 50,
            ),
      title: const Text(
        '(나)',
        style: TextStyle(
          fontFamily: 'NanumSquareNeo-Bold',
        ),
      ),
    );
  }
}
