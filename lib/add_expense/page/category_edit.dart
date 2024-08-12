import 'package:caps_2/add_expense/widget/custom_button.dart';
import 'package:caps_2/models/category.dart';
import 'package:caps_2/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryEdit extends StatelessWidget {
  const CategoryEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Category> activeCategories =
        context.watch<MapProvider>().activeCategories;
    final List<Category> hiddenCategories =
        context.watch<MapProvider>().hiddenCategories;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
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
          '카테고리 편집',
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  const Text(
                    '표시할 카테고리',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'NanumSquareNeo-Bold',
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  // 카테고리 리스트
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: activeCategories.length,
                    itemBuilder: (context, index) {
                      final category = activeCategories[index];

                      return InkWell(
                        onTap: () {
                          context.read<MapProvider>().hideCategory(category);
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Image.asset(category.iconPath),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    category.text,
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'NanumSquareNeo-Bold',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 0,
                              right: 5,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.remove_circle,
                                  color: const Color(0xFFFF6F61),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 40.0),

                  const Text(
                    '숨겨진 카테고리',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'NanumSquareNeo-Bold',
                    ),
                  ),

                  const SizedBox(height: 20.0),

                  // 숨겨진 카테고리 리스트
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: hiddenCategories.length,
                    itemBuilder: (context, index) {
                      final category = hiddenCategories[index];

                      return InkWell(
                        onTap: () {
                          context.read<MapProvider>().showCategory(category);
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Image.asset(category.iconPath),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    category.text,
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'NanumSquareNeo-Bold',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 0,
                              right: 5,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.add_circle,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                title: '완료',
                onTap: () => Navigator.pop(context),
                height: 70,
                color: Colors.red[300]!,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
