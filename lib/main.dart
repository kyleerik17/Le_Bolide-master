import 'package:flutter/material.dart';
import 'package:Bolide/screens/src/features/Pages/splash_screen/pages/splash_screen_page.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreenPage(
            partId: 0,
            userId: 0,
          ),
        );
      },
    );
  }
}
