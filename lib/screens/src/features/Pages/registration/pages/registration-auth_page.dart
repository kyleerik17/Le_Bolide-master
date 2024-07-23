import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:pinput/pinput.dart';

import 'pages.dart';

class RegistrationAuthPage extends StatelessWidget {
  const RegistrationAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) => const RegistrationLastPage(),
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
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 6.h),
            Row(
              children: [
                SizedBox(width: 4.w),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 300),
                        pageBuilder: (_, __, ___) => const RegistrationPage(),
                        transitionsBuilder: (_, animation, __, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(-1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFEBEBEB),
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(2.w),
                    child: Icon(Icons.arrow_back_ios_new, size: 3.w),
                  ),
                ),
                SizedBox(width: 35.w),
                Image.asset(
                  'assets/icons/lgo.png',
                  height: 4.h,
                  fit: BoxFit.contain,
                ),
                const Spacer(flex: 3),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              "Authentification",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontFamily: "Poppins",
                letterSpacing: 0.05,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            Text.rich(
              TextSpan(
                text: "Un SMS sera envoyé au ",
                style: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: "Cabin",
                ),
                children: const <TextSpan>[
                  TextSpan(
                    text: "+221 78 444 56 78",
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            Center(
              child: Pinput(
                length: 4,
                mainAxisAlignment: MainAxisAlignment.center,
                defaultPinTheme: PinTheme(
                  width: 88.5, // 354px / 4
                  height: 60,
                  textStyle: const TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    height: 36.4 / 28, // Line height divided by font size
                    color: Color(0xFF1A1A1A),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.circular(1.h),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 6), // gap: 12px / 2
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Text.rich(
              TextSpan(
                text: "Vous n'avez pas reçu de code ? ",
                style: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: "Cabin",
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "Renvoyer \n",
                    style: TextStyle(
                      color: const Color(0xFF1A1A1A),
                      fontWeight: FontWeight.bold,
                      fontSize: 11.sp,
                    ),
                  ),
                  TextSpan(
                    text: "Recevoir un appel",
                    style: TextStyle(
                      color: const Color(0xFF1A1A1A),
                      fontWeight: FontWeight.bold,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3.h),
            const ImageRotation(),
          ],
        ),
      ),
    );
  }
}

class ImageRotation extends StatefulWidget {
  const ImageRotation({Key? key}) : super(key: key);

  @override
  _ImageRotationState createState() => _ImageRotationState();
}

class _ImageRotationState extends State<ImageRotation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: -_controller.value * 2.0 * 3.141592653589793,
          child: Image.asset(
            'assets/icons/sp.png',
            width: 18.w,
            height: 18.h,
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}