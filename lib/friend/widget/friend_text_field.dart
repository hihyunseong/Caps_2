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
          fontSize: 16,
          fontFamily: 'NanumSquareNeo-Bold',
          color: Colors.grey[400]!,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: const Icon(Icons.search, color: Colors.grey),
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
