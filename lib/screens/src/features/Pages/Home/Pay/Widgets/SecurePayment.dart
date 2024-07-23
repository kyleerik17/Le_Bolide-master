import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget buildSecurePaymentWidget() {
  return Container(
    width: double.infinity,
    color: Colors.white,
    padding: EdgeInsets.symmetric(vertical: 1.h),
    child: Row(
      children: [
        SizedBox(width: 2.w),
        Image.asset(
          'assets/icons/lgo.png',
          width: 8.w,
        ),
        SizedBox(width: 30.w),
        Row(
          children: [
            Image.asset(
              'assets/icons/lock.png',
              width: 8.w,
            ),
            SizedBox(width: 4.w),
            Text(
              'Paiement sécurisé',
              style: TextStyle(
                  fontSize: 12.sp, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    ),
  );
}
