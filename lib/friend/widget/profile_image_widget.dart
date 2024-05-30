import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;

  const ProfileImageWidget({
    super.key,
    this.imageUrl,
    this.width = 50,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return Icon(
        Icons.person,
        size: height,
      );
    }

    return Image.network(
      imageUrl!,
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
