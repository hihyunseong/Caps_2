import 'package:flutter/material.dart';

class FriendTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  const FriendTextField({
    super.key,
    this.hintText = '',
    required this.controller,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: TextStyle(
          fontSize: 13,
          fontFamily: 'NanumSquareNeo-Bold',
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFFC4C4C4),  
            fontSize: 13,              
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ImageIcon(
              AssetImage('assets/images/search/Iconly/Regular/Light/Search.png'),
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: Colors.grey[400]!,
              width: 1.5,
            ),
          ),
          contentPadding: const EdgeInsets.only(left: 20),
        ),
      ),
    );
  }
}
