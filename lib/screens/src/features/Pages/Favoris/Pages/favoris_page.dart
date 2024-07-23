import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:le_bolide/screens/src/features/Pages/Favoris/Widgets/add3.dart';
import 'package:le_bolide/screens/src/features/Pages/Favoris/Widgets/article4.dart';

import 'package:sizer/sizer.dart';

import '../../Home/widgets/appbar.dart';
import '../../loading modal/pages/pages.dart';
import '../Widgets/bottom.dart';

class FavorisPage extends StatefulWidget {
  const FavorisPage({Key? key}) : super(key: key);

  @override
  _FavorisPageState createState() => _FavorisPageState();
}

class _FavorisPageState extends State<FavorisPage> {
 

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
          children: [
            SizedBox(height: 3.h),
            const AppBarWidget(),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.all(2.w),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 1.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1.h),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Rechercher',
                      hintStyle: TextStyle(
                        color: const Color(0xFF737373),
                        fontFamily: 'Poppins',
                        fontSize: 12.sp,
                      ),
                      prefixIcon: ImageIcon(
                        const AssetImage('assets/icons/search.png'),
                        size: 6.w,
                        color: Colors.black,
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
              const Article4Page(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FavorisBottomNavBar(
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

  Widget _buildItem(BuildContext context, Item item) {
    return Row(
      children: [
        Container(
          width: 94.w,
          height: 30.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0.5.h),
          ),
          padding: EdgeInsets.all(1.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(item.imagePath),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(0.5.h),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "Cabin",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          item.subtitleIconPath,
                          width: 6.w,
                          height: 6.w,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          item.subtitle,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: "Cabin",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              item.price,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: "Cabin",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            const Add3Page(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        item.toggleIcon();
                      });
                    },
                    child: Image.asset(
                      item.iconPath,
                      width: 6.w,
                      height: 10.w,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Item {
  final String title;
  final String imagePath;
  final String subtitle;
  final String subtitleIconPath;
  final String price;
  String iconPath = 'assets/icons/hrt2.png';

  Item({
    required this.title,
    required this.imagePath,
    required this.subtitle,
    required this.subtitleIconPath,
    required this.price,
  });

  void toggleIcon() {
    if (iconPath == 'assets/icons/hrt2.png') {
      iconPath = 'assets/icons/oc1.png';
    } else if (iconPath == 'assets/icons/oc1.png') {
      iconPath = 'assets/icons/hrt2.png';
    }
  }
}
