
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import 'onboarding2_page.dart';
import 'pages.dart';

class Onboarding1Page extends StatefulWidget {
  const Onboarding1Page({Key? key}) : super(key: key);

  @override
  State<Onboarding1Page> createState() => _OnboardingPage1State();
}

double loadingProgress = 0.50;

class _OnboardingPage1State extends State<Onboarding1Page> {
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
                          pageBuilder: (_, __, ___) => const OnboardingPage(),
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
                "Découvrez le terrain\n idéal pour votre\n prochaine session !",
                style: TextStyle(
                  fontSize: 23.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.h),
              Image.asset(
                'assets/icons/heart.gif',
                width: 58.w,
                height: 37.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 5.h),
              Text(
                "Obtenez toutes les informations nécessaires et réservez en quelques clics.",
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
                          transitionDuration: Duration(
                              milliseconds: 300), // Durée de la transition
                          pageBuilder: (_, __, ___) =>
                              const Onboarding2Page(), // Page de destination
                          transitionsBuilder: (_, animation, __, child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(
                                    1.0, 0.0), // Début de la transition
                                end: Offset.zero, // Fin de la transition
                              ).animate(animation),
                              child: child,
                            );
                          },
                        ));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
