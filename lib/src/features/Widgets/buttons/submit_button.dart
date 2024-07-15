
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import 'base_button.dart';



class SubmitButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final Function() onPressed;
  final double? horizontalPadding;

  const SubmitButton(
    this.text, {
    required this.onPressed,
    this.color,
    this.textColor,
    this.horizontalPadding, required double width,
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      text,
      color: color ?? Colors.blue,
      textColor: textColor ?? Colors.white,
      onPressed: onPressed,
      horizontalPadding: horizontalPadding,
    );
  }
}
