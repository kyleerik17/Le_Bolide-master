import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget buildOrderSummaryWidget() {
  return Container(
    padding: EdgeInsets.all(2.w),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.w), color: Colors.white),
    child: Row(
      children: [
        Image.asset('assets/images/pn2.png', width: 20.w, height: 20.w),
        SizedBox(width: 2.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Radar Rivera PRO 2 165/65 R13 77T',
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'Cabin',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/sun.png',
                    color: const Color(0xFF1A1A1A),
                    width: 5.w,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    'Pneu été',
                    style: TextStyle(
                      fontFamily: "Cabin",
                      fontSize: 12.sp,
                      color: const Color(0xFF1A1A1A),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.5.h),
              Text(
                '38 000 F',
                style:
                    TextStyle(fontSize: 12.sp, color: const Color(0xFF1A1A1A)),
              ),
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(height: 8.h),
            Container(
              width: 12.w,
              height: 6.w,
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 0.1.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(1.2.w),
              ),
              child: Text(
                '2',
                style: TextStyle(fontSize: 12.sp),
              ),
            )
          ],
        ),
      ],
    ),
  );
}
