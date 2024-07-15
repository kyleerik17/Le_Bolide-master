import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:intl/intl.dart';

import 'package:sizer/sizer.dart';

class InputIntervalDate extends StatefulWidget {
  final Function(DateTime, DateTime) submit;
  final DateTime? initialDate;

  const InputIntervalDate({Key? key, 
   
    required this.submit,
    this.initialDate,
  }) : super(key: key);

  @override
  State<InputIntervalDate> createState() => _InputIntervalDateState();
}

class _InputIntervalDateState extends State<InputIntervalDate> {
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    _endDate = widget.initialDate ?? DateTime.now();
    _startDate = _endDate.subtract(Duration(days: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showNewDatePicker();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(.4)),
          borderRadius: BorderRadius.circular(2.w),
        ),
        padding: EdgeInsets.all(2.w),
        child: Row(
          children: [
            Gap(2.w),
            Expanded(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 12.sp,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(text: "Du "),
                    TextSpan(
                      text: "${dateFormat.format(_startDate)} ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: "au "),
                    TextSpan(
                      text: dateFormat.format(_endDate),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          " (${_endDate.difference(_startDate).inDays} jour(s))",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _showNewDatePicker() async {
    var dates = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.range,
        selectedDayHighlightColor: Colors.blue,
        lastDate: DateTime.now(),
        cancelButton: Container(),
        okButton: Text(
          "Valider",
          style: TextStyle(fontSize: 12.sp),
        ),
      ),
      dialogSize: const Size(325, 400),
      
      value: [_startDate, _endDate],
      borderRadius: BorderRadius.circular(4.w),
    );

    



    setState(() {});
  }
}
