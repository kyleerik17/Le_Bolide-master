import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Assistance/pages/assistance_page.dart';
import '../../Favoris/Pages/favoris_page.dart';
import '../../Home/pages/home_page.dart';
import '../../Commande/pages/commande_page.dart';

class ReservBottomNavBar extends StatelessWidget {
  final int partId;

  final int userId;
  final Function(int) onTap;

  const ReservBottomNavBar({
    Key? key,
    required this.onTap,
    required this.partId,
    required this.userId, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 1.5.w,
          width: 30.h,
          child: const LinearProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            value: 0.4,
          ),
        ),
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedFontSize: 10.sp,
          unselectedFontSize: 10.sp,
          unselectedItemColor: Colors.grey,
          currentIndex: 0, // Static, no state change
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 1.w),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/icons/ho.png',
                      height: 8.w,
                      width: 8.w,
                    ),
                    const Text(
                      'Acceuil',
                      style: TextStyle(
                        fontFamily: "Cabin",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 1.w),
                child: Column(
                  children: [
                    Image.asset('assets/icons/recs.png',
                        height: 8.w, width: 8.w, color: Colors.black),
                    const Text(
                      'Commandes',
                      style: TextStyle(
                        fontFamily: "Cabin",
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(), // Empty space for the central item
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 1.w),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/icons/ring.png',
                      height: 8.w,
                      width: 8.w,
                    ),
                    const Text(
                      'Assistance',
                      style: TextStyle(
                        fontFamily: "Cabin",
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF737373),
                      ),
                    ),
                  ],
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 1.w),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/icons/cr.png',
                      height: 8.w,
                      width: 8.w,
                    ),
                    const Text(
                      'Favoris',
                      style: TextStyle(
                        fontFamily: "Cabin",
                        color: Color(0xFF737373),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              label: '',
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      partId: partId,
                      userId: userId,
                    ),
                  ),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommandePage(
                      partId: partId,
                      userId: userId,
                    ),
                  ),
                );
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AssistancePage(
                      partId: partId,
                      userId: userId,
                    ),
                  ),
                );
                break;
              case 4:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavorisPage(
                      partId: partId,
                      userId: userId,
                   
                    ),
                  ),
                );
                break;
            }
            onTap(index); // Call the onTap function passed as a parameter
          },
        ),
      ],
    );
  }
}
