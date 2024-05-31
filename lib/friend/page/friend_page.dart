import 'package:caps_2/friend/provider/friend_provider.dart';
import 'package:caps_2/friend/view/friend_search_view.dart';
import 'package:caps_2/friend/view/friend_list_view.dart';
import 'package:caps_2/friend/view/friend_request_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendPage extends StatelessWidget {
  const FriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    final friendProvider = context.watch<FriendProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '친구',
          style: TextStyle(
            fontSize: 20,
            fontFamily: "NanumSquareNeo-Bold",
          ),
        ),
        centerTitle: true,
      ),
      body: DefaultTabController(
        animationDuration: const Duration(milliseconds: 400),
        length: 3,
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: TabBar(
                padding: const EdgeInsets.only(bottom: 20.0),
                indicatorColor: Colors.red,
                indicatorWeight: 2,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                dividerHeight: 0,
                tabs: [
                  Text(
                    '친구 목록 ${friendProvider.friendList.length}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'NanumSquareNeo-Bold',
                    ),
                  ),
                  Text(
                    '친구 요청 ${friendProvider.friendRequestToMeList.length}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'NanumSquareNeo-Bold',
                    ),
                  ),
                  const Text(
                    '친구 찾기',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'NanumSquareNeo-Bold',
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    FriendListView(),
                    FriendRequestView(),
                    FriendSearchView(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
