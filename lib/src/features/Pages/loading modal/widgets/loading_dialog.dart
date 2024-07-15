import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void _showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: EdgeInsets.all(0),
        child: Container(
          alignment: Alignment.center,
               color: Colors.transparent,
          child: SizedBox(
            width: 20.w,
            height: 20.w,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              strokeWidth: 6,
            ),
          ),
        ),
      );
    },
  );
}
