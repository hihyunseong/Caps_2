import 'package:flutter/material.dart';

class CommentKeyboardView extends StatefulWidget {
  const CommentKeyboardView({
    super.key,
    required this.textEditingController,
    required this.onSendButtonPressed,
  });

  final TextEditingController textEditingController;
  final VoidCallback onSendButtonPressed;

  @override
  State<CommentKeyboardView> createState() => _CommentKeyboardViewState();
}

class _CommentKeyboardViewState extends State<CommentKeyboardView> {
  double nowHeight = 58;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: nowHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TextField(
                controller: widget.textEditingController,
                keyboardType: TextInputType.multiline,
                expands: true,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'NanumSquareNeo-Bold',
                  color: Colors.black,
                  decorationThickness: 0,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            InkWell(
              onTap: widget.onSendButtonPressed,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
