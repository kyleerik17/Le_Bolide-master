import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PromoCodeWidget extends StatelessWidget {
  const PromoCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.all(4.w), // Ajout du padding autour du Container blanc
      child: Container(
        padding: EdgeInsets.all(2.w), // Padding interne du Container blanc
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/pct.png',
              width: 4.w,
              height: 4.w,
            ),
            SizedBox(width: 1.w),
            Text(
              '-10% DE REDUCTION AVEC LE CODE "BOL10"',
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Cabin',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
