import 'package:flutter/material.dart';

class CustomImageContainer extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double borderRadius;

  CustomImageContainer({
    required this.imageUrl,
    this.height = 180.0,
    this.width = double.infinity,
    this.borderRadius = 15.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
