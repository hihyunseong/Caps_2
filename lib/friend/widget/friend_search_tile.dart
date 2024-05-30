import 'package:caps_2/friend/model/friend_model.dart';
import 'package:caps_2/friend/provider/friend_provider.dart';
import 'package:caps_2/friend/widget/profile_image_widget.dart';
import 'package:caps_2/utils/app_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendSearchTile extends StatelessWidget {
  final FriendModel friend;

  const FriendSearchTile({
    super.key,
    required this.friend,
  });

  @override
  Widget build(BuildContext context) {
    final friendProvider = context.read<FriendProvider>();

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
        Text(AppUtil.getTimeAgo(friend.updatedAt)),
        TextButton(
          onPressed: () {
            friendProvider.requestFriend(friend.idx);
          },
          child: const Text(
            '친구 추가',
            style: TextStyle(
              color: Colors.red,
              fontFamily: 'NanumSquareNeo-Bold',
            ),
          ),
        )
      ],
    );
  }
}
