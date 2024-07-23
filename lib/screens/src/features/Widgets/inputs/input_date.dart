
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:sizer/sizer.dart';

import 'input_date_picker_dialog.dart';


class InputDate extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool obscureText;
  final Color? backgroundColor;
  final bool enabled;
  final TextCapitalization? capitalization;
  final Function(DateTime) onSelected;

  const InputDate({
    Key? key,
    required this.controller,
    required this.onSelected,
    this.hintText,
    this.prefixIcon,
    this.keyboardType,
    this.maxLength,
    this.obscureText = false,
    this.enabled = true,
    this.backgroundColor,
    this.capitalization,
  }) : super(key: key);

  @override
  State<InputDate> createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  late DateTime selectedDate;

  @override
  void initState() {
    selectedDate = DateTime.now().subtract(Duration(days: 365 * 18));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(2.w),
          border: Border.all(color: Colors.blue.withOpacity(0.5))),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        enabled: widget.enabled,
        readOnly: true,
        onTap: () {
          _showDatePickerDialog();
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: 2.h,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(4.w),
           
          ),
          hintStyle: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey,
          ),
        ),
        textCapitalization: widget.capitalization ?? TextCapitalization.none,
        style: TextStyle(fontSize: 12.sp, color: Colors.black),
        maxLength: widget.maxLength,
        buildCounter: (context,
                {int? currentLength, bool? isFocused, int? maxLength}) =>
            null,
      ),
    );
  }

  _showDatePickerDialog() async {
    var pickerDate = await showCupertinoDialog<DateTime?>(
      context: context,
      builder: (BuildContext context) =>
          InputDatePickerDialog(initialDate: selectedDate),
    );
    if (pickerDate != null) {
      selectedDate = pickerDate;
      // widget.controller.text = selectedDate.toHumanDate;
      setState(() {});
    }
  }
}
