import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InputText extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? prefixText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool obscureText;
  final Color? backgroundColor;
  final bool enabled;
  final TextCapitalization? capitalization;
  final Function(String?)? onChanged;
  final bool readOnly;
  final Function()? onTap;
  
  

  const InputText({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.keyboardType,
    this.maxLength,
    this.obscureText = false,
    this.enabled = true,
    this.backgroundColor,
    this.capitalization,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: enabled
            ? backgroundColor ?? Colors.white
            : Colors.blue.withOpacity(0.3),
        borderRadius: BorderRadius.circular(2.w),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        enabled: enabled,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: 3.w,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(
            fontSize: 12.sp,
          ),
        ),
        onTap: onTap,
        onChanged: onChanged,
        textCapitalization: capitalization ?? TextCapitalization.none,
        style: TextStyle(fontSize: 12.sp, color: Colors.black),
        maxLength: maxLength,
        buildCounter: (context,
                {int? currentLength, bool? isFocused, int? maxLength}) =>
            null,
        readOnly: readOnly,
      ),
    );
  }
}
