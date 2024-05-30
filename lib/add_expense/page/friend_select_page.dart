import 'package:caps_2/add_expense/page/expense_detail_page.dart';
import 'package:caps_2/add_expense/widget/custom_button.dart';
import 'package:caps_2/friend/model/friend_model.dart';
import 'package:caps_2/models/map_model.dart';
import 'package:flutter/material.dart';
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
  final _controller = TextEditingController();
  final List<FriendModel> selectedFriends = [];

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
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'NanumSquareNeo-Bold',
                      color: Colors.grey[400]!,
                    ),
                    decoration: InputDecoration(
                      hintText: '함께 한 멤버를 검색해보세요',
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
                const SizedBox(height: 10),
                // Expanded(
                //   child: ValueListenableBuilder<String>(
                //     valueListenable: _searchText,
                //     builder: (context, searchText, child) {
                //       final filteredMapList = mapProvider.mapList.where((map) {
                //         return map.mapName.contains(searchText);
                //       }).toList();
                //       return ListView(
                //         children: filteredMapList.reversed
                //             .map(
                //               (e) => MapSelectListTile(
                //                 mapModel: e,
                //                 onTap: () {
                //                   setState(() {
                //                     selectedMapModel = e;
                //                   });
                //                 },
                //               ),
                //             )
                //             .toList(),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                title: '다음',
                height: 70,
                color: Color(0xFFFF6F61),
                // color: (selectedMapModel == null)
                //     ? Colors.red[100]!
                //     : Colors.red[300]!,
                onTap: () {
                  // if (selectedMapModel == null) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //       content: Text('맵을 선택해주세요.'),
                  //     ),
                  //   );
                  //   return;
                  // }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExpenseDetailPage(
                        amount: widget.amount,
                        location: widget.location,
                        date: widget.date,
                        expenseLocationName: widget.expenseLocationName,
                        mapModel: widget.mapModel,
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
}
