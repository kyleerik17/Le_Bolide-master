import 'package:flutter/material.dart';
import 'package:le_bolide/src/features/Pages/Home/pages/home_page.dart';
import 'package:sizer/sizer.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

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
                builder: (context) => const HomePage(),
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
