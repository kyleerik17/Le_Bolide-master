import 'package:flutter/material.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/pages/home_page.dart';

import 'package:sizer/sizer.dart';

class TopBar extends StatelessWidget {
  final int partId;
  final int userId;
  final int quantity;
  const TopBar(
      {Key? key,
      required this.partId,
      required this.quantity,
      required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(height: 3.h),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  partId: partId,
                  userId: userId,
                ),
              ),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFEBEBEB),
            ),
            padding: EdgeInsets.all(0.w),
            child: Image.asset(
              'assets/icons/close.png',
              width: 12.w,
              height: 12.w,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
