import 'package:caps_2/friend/provider/friend_provider.dart';
import 'package:caps_2/friend/view/friend_search_view.dart';
import 'package:caps_2/friend/view/friend_list_view.dart';
import 'package:caps_2/friend/view/friend_request_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final friendProvider = context.watch<FriendProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/images/arrow_left/vuesax/linear/arrow_left.png',
            width: 24,
            height: 24,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          '친구',
          style: TextStyle(
            fontSize: 18,
            fontFamily: "NanumSquareNeo-Bold",
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: TabBar(
              controller: _tabController,
              padding: const EdgeInsets.only(bottom: 20.0),
              indicatorColor: Color(0xFFFF6F61),
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.tab,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              labelColor: Color(0xFFFF6F61),
              unselectedLabelColor: Color(0xFFC4C4C4),
              tabs: [
                Tab(
                  text: '친구 목록 ${friendProvider.friendList.length}',
                ),
                Tab(
                  text: '친구 요청 ${friendProvider.friendRequestToMeList.length}',
                ),
                const Tab(
                  text: '친구 찾기',
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
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
    );
  }
}
