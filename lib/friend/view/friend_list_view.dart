import 'package:caps_2/friend/provider/friend_provider.dart';
import 'package:caps_2/friend/widget/friend_list_tile.dart';
import 'package:caps_2/friend/widget/friend_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 친구 목록
class FriendListView extends StatefulWidget {
  const FriendListView({super.key});

  @override
  State<FriendListView> createState() => _FriendListViewState();
}

class _FriendListViewState extends State<FriendListView> {
  final TextEditingController friendListController = TextEditingController();
  final ValueNotifier<String> _searchText = ValueNotifier<String>("");

  @override
  void initState() {
    super.initState();
    friendListController.addListener(() {
      _searchText.value = friendListController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final friendProvider = context.watch<FriendProvider>();
    return Column(
      children: [
        FriendTextField(
          controller: friendListController,
          hintText: '친구의 닉네임을 검색해보세요.',
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ValueListenableBuilder<String>(
            valueListenable: _searchText,
            builder: (context, searchText, child) {
              final filteredFriendList =
                  friendProvider.friendList.where((friend) {
                return friend.name.contains(searchText);
              }).toList();
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.6,
                ),
                itemCount: filteredFriendList.length,
                itemBuilder: (context, index) {
                  return FriendListTile(
                    friend: filteredFriendList[index],
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
