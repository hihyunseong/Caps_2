import 'package:caps_2/add_expense/page/expense_detail_page.dart';
import 'package:caps_2/add_expense/page/friend_select_page.dart';
import 'package:caps_2/add_expense/widget/custom_button.dart';
import 'package:caps_2/add_expense/widget/map_select_list_tile.dart';
import 'package:caps_2/models/map_model.dart';
import 'package:caps_2/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapSelectPage extends StatefulWidget {
  final double amount;
  final LatLng location;
  final DateTime date;
  final String expenseLocationName;

  const MapSelectPage({
    super.key,
    required this.amount,
    required this.location,
    required this.date,
    required this.expenseLocationName,
  });

  @override
  State<MapSelectPage> createState() => _MapSelectPageState();
}

class _MapSelectPageState extends State<MapSelectPage> {
  MapModel? selectedMapModel;
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<String> _searchText = ValueNotifier<String>("");

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _searchText.value = _controller.text;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = context.watch<MapProvider>();
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
          '맵 선택',
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
                      hintText: '맵을 검색해보세요',
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
                Expanded(
                  child: ValueListenableBuilder<String>(
                    valueListenable: _searchText,
                    builder: (context, searchText, child) {
                      final filteredMapList = mapProvider.mapList.where((map) {
                        return map.mapName.contains(searchText);
                      }).toList();
                      return ListView(
                        children: filteredMapList.reversed
                            .map(
                              (e) => MapSelectListTile(
                                mapModel: e,
                                onTap: () {
                                  setState(() {
                                    selectedMapModel = e;
                                  });
                                },
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                title: '다음',
                height: 70,
                color: (selectedMapModel == null)
                    ? Colors.red[100]!
                    : Colors.red[300]!,
                onTap: () {
                  if (selectedMapModel == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('맵을 선택해주세요.'),
                      ),
                    );
                    return;
                  }

                  // 공유맵인 경우 친구 선택
                  if (selectedMapModel!.isSharedMap) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FriendSelectPage(
                          amount: widget.amount,
                          location: widget.location,
                          date: widget.date,
                          expenseLocationName: widget.expenseLocationName,
                          mapModel: selectedMapModel!,
                        ),
                      ),
                    );
                  } else {
                    // 공유 맵 아닌 경우 바로 소비기록 페이지
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpenseDetailPage(
                          amount: widget.amount,
                          location: widget.location,
                          date: widget.date,
                          expenseLocationName: widget.expenseLocationName,
                          mapModel: selectedMapModel!,
                          selectedFriends: [],
                        ),
                      ),
                    );
                  }

                  return;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
