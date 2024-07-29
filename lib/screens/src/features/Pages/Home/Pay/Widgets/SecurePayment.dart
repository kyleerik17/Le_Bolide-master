import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget buildSecurePaymentWidget() {
  return Container(
    width: double.infinity,
    color: Colors.white,
    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/icons/lgo.png',
          width: 8.w,
        ),
        Row(
          children: [
            Image.asset(
              'assets/icons/lock.png',
              width: 8.w,
            ),
            SizedBox(width: 4.w),
            Text(
              'Paiement sécurisé',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    ),
  );
}
