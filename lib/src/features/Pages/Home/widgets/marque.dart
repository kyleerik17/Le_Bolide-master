import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MarquePopu extends StatelessWidget {
  const MarquePopu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildMarque(
              imagePath: 'assets/icons/hd.png', label: 'HYUNDAI', onTap: () {}),
          SizedBox(width: 2.w),
          _buildMarque(
              imagePath: 'assets/icons/mcd.png',
              label: 'MERCEDES',
              onTap: () {}),
          _buildMarque(
              imagePath: 'assets/icons/bmw.png', label: 'BMW', onTap: () {}),
          SizedBox(width: 2.w),
          _buildMarque(
              imagePath: 'assets/icons/mcd.png',
              label: 'MERCEDES',
              onTap: () {}),
          SizedBox(width: 2.w),
        ],
      ),
    );
  }

  Widget _buildMarque({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 30.w,
            height: 25.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                width: 25.w,
                height: 25.w,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            label,
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Cabin'),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
