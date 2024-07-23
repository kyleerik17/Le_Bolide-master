import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';


class BaseButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final Function() onPressed;
  final Color? borderColor;
  final double? horizontalPadding;

  const BaseButton(
    this.text, {
    required this.onPressed,
    this.color,
    this.textColor,
    this.borderColor,
    this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 16.w, vertical: 1.5.h)),
        textStyle: MaterialStateProperty.all(TextStyle(fontSize: 14.sp)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.w),
            side: borderColor != null
                ? BorderSide(color: borderColor!)
                : BorderSide.none,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: textColor,
            fontSize: 12.sp,
             fontFamily: "Cabin",),
      ),
    );
  }
}
