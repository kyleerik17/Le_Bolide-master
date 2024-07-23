import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../Home/pages/pages.dart';

class RegistrationCongratulationPage extends StatelessWidget {
  const RegistrationCongratulationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 100.h,
            width: 100.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/carr.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 44.w),
              Image.asset(
                'assets/icons/home.png',
                height: 20.w,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "BOLIDE",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 25.sp,
                      fontFamily: "Hemi head",
                      letterSpacing: 0.05,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 42.w),
              Text(
                "Votre bolide vous remerciera",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp,
                  fontFamily: "Poppins",
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50.w),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 300),
                      pageBuilder: (_, __, ___) => const HomePage(),
                      transitionsBuilder: (_, animation, __, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFFFFF),
                  padding:
                      EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.h),
                  ),
                ),
                child: Text(
                  "Commencer",
                  style: TextStyle(
                    color: const Color(0xFF1A1A1A),
                    fontSize: 12.sp,
                    fontFamily: "Cabin",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
