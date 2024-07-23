import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ContactOptions extends StatelessWidget {
  final bool isDropdownSelected;

  const ContactOptions({
    Key? key,
    required this.isDropdownSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isDropdownSelected)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFC9CDD2)),
              borderRadius: BorderRadius.circular(1.5.w),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/wp.png',
                  height: 14.w,
                ),
                const SizedBox(width: 8.0),
                const Expanded(
                  child: Text(
                    'Contacter par WhatsApp',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Cabin',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/icons/dt.png',
                  color: Colors.black,
                  height: 4.w,
                  width: 3.w,
                ),
              ],
            ),
          ),
        SizedBox(height: 1.h),
        if (!isDropdownSelected)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFC9CDD2)),
              borderRadius: BorderRadius.circular(1.5.w),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/oe.png',
                  height: 14.w,
                ),
                const SizedBox(width: 8.0),
                const Expanded(
                  child: Text(
                    'Appeler un commercial',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Cabin',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/icons/dt.png',
                  color: Colors.black,
                  height: 4.w,
                  width: 3.w,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
