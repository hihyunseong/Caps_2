import 'dart:io';

import 'package:caps_2/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// expenses_panel 에서 날짜 클릭 했을 때 보이는 페이지 위젯
class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final Function() onTap;
  final double imageHeight;
  final double imageWidth;

  const ExpenseTile({
    super.key,
    required this.expense,
    required this.onTap,
    this.imageHeight = 120,
    this.imageWidth = 120,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  expense.category.iconPath,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.content,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'NanumSquareNeo-Bold',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        '${DateFormat('HH:mm').format(expense.date)} | ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 9,
                          fontFamily: 'NanumSquareNeo-Bold',
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '${expense.payMethod.name} ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 9,
                          fontFamily: 'NanumSquareNeo-Bold',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  if (expense.imagePath != null) ...[
                    const SizedBox(height: 10),
                    if (expense.imagePath!.startsWith('http')) ...[
                      Image.network(
                        expense.imagePath!,
                        width: imageWidth,
                        height: imageHeight,
                        fit: BoxFit.cover,
                      ),
                    ] else ...[
                      Image.file(
                        File(expense.imagePath!),
                        width: imageWidth,
                        height: imageHeight,
                        fit: BoxFit.cover,
                      ),
                    ],      
                  ],
                  const SizedBox(height: 10),
                  Text(
                    expense.memo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontFamily: 'NanumSquareNeo-Bold',
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            Text(
              '₩ ${NumberFormat('###,###').format(expense.amount.toInt())}',
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'NanumSquareNeo-Bold',
              ),
            ),
          ],
        ),
      ),
    );
  }
}