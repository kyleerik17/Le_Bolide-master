
import 'package:flutter/material.dart';
import 'package:le_bolide/src/features/Widgets/buttons/base_button.dart';

import 'package:sizer/sizer.dart';



class CancelButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final double? horizontalPadding;
  final Color? borderColor;
  final Color? textColor;

  const CancelButton(
    this.text, {
    required this.onPressed,
    this.horizontalPadding,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      text,
      color: Colors.white,
      textColor: textColor ?? Colors.black,
      onPressed: onPressed,
      borderColor: borderColor ?? Colors.black,
      horizontalPadding: horizontalPadding,
    );
  }
}
