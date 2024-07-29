import 'package:flutter/material.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/pages/home_page.dart';
import 'package:sizer/sizer.dart';

import 'package:gap/gap.dart';

import '../../../profile/pages/pages.dart';

class MenuPage extends StatelessWidget {
  final int partId;
  final int userId;
  const MenuPage({Key? key, required this.partId, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: SizedBox(
        child: Container(
          color: const Color(0xFF1A1A1A),
          child: ListView(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 25.w),
                          Image.asset(
                            'assets/icons/home.png',
                            width: 45.w,
                            height: 13.w,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(9.w),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProfilePage(partId ,userId)),
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.person, color: Colors.white),
                            SizedBox(width: 4.w),
                            const Text(
                              'Profil',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                fontFamily: "Cabin",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          const Icon(Icons.settings, color: Colors.white),
                          SizedBox(width: 4.w),
                          const Text(
                            'Paramètres',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Gap(105.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/insta.png',
                    color: Colors.white,
                  ),
                  Gap(8.w),
                  Image.asset(
                    'assets/icons/fb.png',
                    color: Colors.white,
                  ),
                  Gap(8.w),
                  Image.asset(
                    'assets/icons/tt.png',
                    color: Colors.white,
                  ),
                  Gap(8.w),
                  Image.asset(
                    'assets/icons/lg.png',
                    color: Colors.white,
                  ),
                ],
              ),
              Gap(15.w),
              Center(
                child: Text(
                  'À Propos Du Développeur',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 4.w,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Cabin",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
