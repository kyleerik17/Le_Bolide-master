
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'onboarding1_page.dart';
import 'onboarding3_page.dart';


class Onboarding2Page extends StatefulWidget {
  const Onboarding2Page({Key? key}) : super(key: key);

  @override
  State<Onboarding2Page> createState() => _Onboarding2PageState();
}

double loadingProgress = 0.75;

class _Onboarding2PageState extends State<Onboarding2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 300),
                          pageBuilder: (_, __, ___) => const Onboarding1Page(),
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
                  ),
                  SizedBox(width: 11.h),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "book ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            fontFamily: "Poppins",
                            letterSpacing: 0.05,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "it",
                          style: TextStyle(
                            color: Color(0xFFEA7C17),
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            fontFamily: "Poppins",
                            letterSpacing: 0.05,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Container(
                width: 80.w,
                child: LinearProgressIndicator(
                  value: loadingProgress,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Réservez votre créneau sportif en toute simplicité !",
                style: TextStyle(
                  fontSize: 23.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.h),
              Image.asset(
                'assets/icons/search.gif',
                width: 58.w,
                height: 37.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 5.h),
              Text(
                "Choisissez votre horaire, payez en ligne et recevez une confirmation instantanée.",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: "Cabin",
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.h),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 300),
                      pageBuilder: (_, __, ___) => const Onboarding3Page(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
