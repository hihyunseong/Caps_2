import 'dart:io';

import 'package:caps_2/enums/map_status.dart';
import 'package:caps_2/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpenseDetailsPanel extends StatelessWidget {
  const ExpenseDetailsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    final mapModel = mapProvider.mapModel!;
    final expense = mapProvider.expense!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFC4C4C4),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          const SizedBox(height: 10.0),

          // title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: mapModel.isSharedMap
                    ? () =>
                        mapProvider.changeShareMapStatus(MapStatus.mapDetails)
                    : () => mapProvider.changeMyMapStatus(MapStatus.mapDetails),
                icon: const Icon(Icons.arrow_back),
              ),
              Text(
                mapModel.mapName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const IconButton(
                onPressed: null,
                icon: Icon(Icons.more_vert, color: Colors.transparent),
              ),
            ],
          ),

          // expense details
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        expense.category.text,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        DateFormat('yyyy.MM.dd mm:ss').format(expense.date),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 93, 93, 93),
                        ),
                      ),
                      trailing: Text(
                        '${NumberFormat('###,###').format(expense.amount.toInt())}원',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (expense.imagePath != null)
                      Image.file(
                        File(expense.imagePath!),
                        width: 170,
                        height: 170,
                        fit: BoxFit.cover,
                      ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        expense.content,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        expense.memo,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
