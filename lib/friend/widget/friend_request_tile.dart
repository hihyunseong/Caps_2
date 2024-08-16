import 'package:caps_2/friend/model/request_friend_model.dart';
import 'package:caps_2/friend/provider/friend_provider.dart';
import 'package:caps_2/friend/widget/profile_image_widget.dart';
import 'package:caps_2/common/utils/app_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendRequestTile extends StatelessWidget {
  final RequestFriendModel friend;

  const FriendRequestTile({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    final friendProvider = context.read<FriendProvider>();
    return Column(
      children: [
        ProfileImageWidget(
          imageUrl: friend.profile,
          width: 60,
          height: 60,
        ),
        Text(
          friend.username,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'NanumSquareNeo-Bold',
            fontSize: 12
          ),
        ),
        Text(
          AppUtil.getTimeAgo(friend.createdAt),
          style: TextStyle(
            fontSize: 10, 
            color: const Color(0xFF9D9D9D),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  friendProvider.acceptFriend(friend.friendIdx);
                },
                child: const Text(
                  '수락',
                  style: TextStyle(
                    color: const Color(0xFFFF6F61),
                    fontFamily: 'NanumSquareNeo-Bold',
                    fontSize: 12.0
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  friendProvider.declineFriend(friend.friendIdx);
                },
                child: const Text(
                  '거절',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'NanumSquareNeo-Bold',
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
