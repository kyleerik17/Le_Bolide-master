import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Home/pages/pages.dart';

class RegistrationCongratulationPage extends StatelessWidget {
  final int partId;
  final int userId;
  final String phoneNumber;
  const RegistrationCongratulationPage(
      {super.key,
      required this.partId,
      required this.userId,
      required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fond d'écran
          Container(
            height: 100.h,
            width: 100.w, // Correction de la largeur
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/carr.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenu de la page
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
                  print('Navigating to HomePage with partId: $partId');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        partId: partId,
                        userId: userId,
                      ),
                    ),
                  );
                    (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            };
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
