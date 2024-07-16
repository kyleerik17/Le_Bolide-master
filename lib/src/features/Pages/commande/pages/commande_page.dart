import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:le_bolide/src/features/Pages/loading%20modal/pages/search_load_page.dart';
import 'package:sizer/sizer.dart';

import '../../Home/widgets/appbar.dart';

import '../widgets/bottom.dart';
import '../widgets/commande_container.dart';

class CommandePage extends StatefulWidget {
  const CommandePage({Key? key}) : super(key: key);

  @override
  _CommandePageState createState() => _CommandePageState();
}

class _CommandePageState extends State<CommandePage> {
  String _selectedButton = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      _selectedButton = buttonText;
    });
  }

  @override
  Widget build(BuildContext context) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 3.h),
            const AppBarWidget(),
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(1.h),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Rechercher',
                      hintStyle: TextStyle(
                        color: const Color(0xFF737373),
                        fontFamily: 'Poppins,',
                        fontSize: 10.sp,
                      ),
                      prefixIcon: ImageIcon(
                        const AssetImage('assets/icons/search.png'),
                        size: 5.w,
                        color: Colors.black,
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: _selectedButton == 'Tout'
                              ? Colors.black
                              : Colors.white,
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.5.h),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          minimumSize: Size(0, 3.8.h),
                        ),
                        onPressed: () => _onButtonPressed('Tout'),
                        child: Text(
                          'Tout',
                          style: TextStyle(
                            color: _selectedButton == 'Tout'
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                      Gap(2.w),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: _selectedButton == 'En cours'
                              ? Colors.black
                              : Colors.white,
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.5.h),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          minimumSize: Size(0, 3.8.h),
                        ),
                        onPressed: () => _onButtonPressed('En cours'),
                        child: Text(
                          'En cours',
                          style: TextStyle(
                            color: _selectedButton == 'En cours'
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                      Gap(2.w),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: _selectedButton == 'Terminées'
                              ? Colors.black
                              : Colors.white,
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.5.h),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          minimumSize: Size(0, 3.8.h),
                        ),
                        onPressed: () => _onButtonPressed('Terminées'),
                        child: Text(
                          'Terminées',
                          style: TextStyle(
                            color: _selectedButton == 'Terminées'
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Commandes en cours',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Voir tout',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "Cabin",
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "16/06/2024",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Cabin',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  const CommandeContainer(
                    price: '68 400 F',
                    description: 'Commande XDR 980 992',
                    assetIcon: 'assets/icons/rec.png',
                  ),
                  SizedBox(height: 1.h),
                  const CommandeContainer(
                    price: '250 000 F',
                    description: 'Commande MLR 789 009',
                    assetIcon: 'assets/icons/rec.png',
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Commandes antérieures',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Voir tout',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "Cabin",
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "14/05/2024",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Cabin',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  const CommandeContainer(
                    price: '24 500 F',
                    description: 'Commande LLS 192 034',
                    assetIcon: 'assets/icons/rec.png',
                  ),
                  SizedBox(height: 1.h),
                  const CommandeContainer(
                    price: '45 800 F',
                    description: 'Commande SRF 900 984',
                    assetIcon: 'assets/icons/rec.png',
                  ),
                  SizedBox(height: 1.h),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ReservBottomNavBar(
        onTap: (int) {},
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(
              bottom: 7.h), // Ajustez cette valeur selon vos besoins
          width: 20.w,
          height: 20.w,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 300),
                  pageBuilder: (_, __, ___) => const SearchLoadPage(),
                  transitionsBuilder: (_, animation, __, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 1.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13.w),
            ),
            backgroundColor: Colors.black,
            child: Image.asset(
              'assets/icons/home.png',
              width: 10.w,
              height: 10.h,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
