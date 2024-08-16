import 'package:caps_2/friend/provider/friend_provider.dart';
import 'package:caps_2/friend/widget/friend_request_tile.dart';
import 'package:caps_2/friend/widget/friend_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 친구 요청
class FriendRequestView extends StatefulWidget {
  const FriendRequestView({super.key});

  @override
  State<FriendRequestView> createState() => _FriendRequestViewState();
}

class _FriendRequestViewState extends State<FriendRequestView> {
  final TextEditingController friendRequestController = TextEditingController();
  final ValueNotifier<String> _searchText = ValueNotifier<String>("");

  @override
  void initState() {
    super.initState();
    friendRequestController.addListener(() {
      _searchText.value = friendRequestController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final friendProvider = context.watch<FriendProvider>();

    return Column(
      children: [
        FriendTextField(
          controller: friendRequestController,
          hintText: '친구의 닉네임을 검색해보세요.',
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ValueListenableBuilder<String>(
            valueListenable: _searchText,
            builder: (context, searchText, child) {
              final filteredRequestFriendList =
                  friendProvider.friendRequestToMeList.where((friend) {
                return friend.username.contains(searchText);
              }).toList();
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.6,
                ),
                itemCount: filteredRequestFriendList.length,
                itemBuilder: (context, index) {
                  return FriendRequestTile(
                    friend: filteredRequestFriendList[index],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
