
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../buttons/buttons.dart';


class InputDatePickerDialog extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? minDate;
  const InputDatePickerDialog({Key? key, 
   
    this.initialDate,
    this.minDate,
  }) : super(key: key);

  @override
  State<InputDatePickerDialog> createState() => _InputDatePickerDialogState();
}

class _InputDatePickerDialogState extends State<InputDatePickerDialog> {
  late DateTime? initialDate;
  late DateTime? maximumDate;

  @override
  void initState() {
    initialDate = widget.initialDate ?? DateTime.now();
    maximumDate = DateTime.now().add(Duration(days: 3650));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.3),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.35,
          padding: EdgeInsets.all(4.w),
          margin: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.w),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(1.w),
                      child: Icon(
                        Icons.close,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                Expanded(
                  child: CupertinoDatePicker(
                    initialDateTime: widget.initialDate,
                    mode: CupertinoDatePickerMode.date,
                    use24hFormat: true,
                    showDayOfWeek: false,
                    onDateTimeChanged: (DateTime newDate) {
                      initialDate = newDate;
                    },
                    maximumDate: maximumDate,
                    minimumDate: widget.minDate,
                  ),
                ),
                SizedBox(height: 2.h),
                SubmitButton(
                  "Valider",
                  onPressed: () {
                    Navigator.pop(context, initialDate);
                  },width: double.infinity,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
