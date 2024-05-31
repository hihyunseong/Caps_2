import 'package:caps_2/friend/provider/friend_provider.dart';
import 'package:caps_2/friend/widget/friend_search_tile.dart';
import 'package:caps_2/friend/widget/friend_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 친구 검색
class FriendSearchView extends StatelessWidget {
  const FriendSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final friendProvider = context.watch<FriendProvider>();

    return Column(
      children: [
        FriendTextField(
          controller: friendProvider.friendFindController,
          hintText: '친구의 이메일을 검색해보세요',
          onSubmitted: (value) {
            friendProvider.searchFriend(value);
          },
        ),
        const SizedBox(height: 20),
        if (friendProvider.searchedFriend != null)
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.6,
              ),
              itemCount: 1,
              itemBuilder: (context, index) {
                return FriendSearchTile(friend: friendProvider.searchedFriend!);
              },
            ),
          )
      ],
    );
  }
}
