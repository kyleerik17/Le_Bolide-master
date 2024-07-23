import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Article2Page extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String price;

  const Article2Page({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price, required Null Function() onAddPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(imageUrl),
        Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        Text(description, style: TextStyle(fontSize: 12.sp)),
        Text('\$$price', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
        const Divider(),
      ],
    );
  }
}
