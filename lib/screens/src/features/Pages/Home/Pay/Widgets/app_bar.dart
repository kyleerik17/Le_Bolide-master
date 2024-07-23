import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../Pages/pages.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    leading: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Pay2Page(),
          ),
        );
      },
      child: Image.asset(
        'assets/icons/gc.png',
        width: 15.w,
        height: 15.w,
        color: Colors.black,
      ),
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    title: Text(
      'Confirmation',
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
    centerTitle: true,
  );
}
