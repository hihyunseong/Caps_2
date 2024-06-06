import 'package:caps_2/friend/model/friend_model.dart';
import 'package:caps_2/friend/provider/friend_provider.dart';
import 'package:caps_2/friend/widget/profile_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendListTile extends StatelessWidget {
  final FriendModel friend;

  const FriendListTile({
    super.key,
    required this.friend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileImageWidget(
          imageUrl: friend.profile,
          width: 70,
          height: 70,
        ),
        Text(
          friend.name,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'NanumSquareNeo-Bold',
          ),
        ),
        TextButton(
          onPressed: () {
            context.read<FriendProvider>().deleteFriend(friend.idx);
          },
          child: const Text(
            '삭제',
            style: TextStyle(
              color: Color(0xFF9D9D9D),
              fontFamily: 'NanumSquareNeo-Bold',
              fontSize: 13.0,
            ),
          ),
        )
      ],
    );
  }
}
