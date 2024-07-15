import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget buildStep(String title) {
  return Row(
    children: [
      Text(
        title,
        style: TextStyle(fontSize: 11.sp),
      ),
    ],
  );
}
