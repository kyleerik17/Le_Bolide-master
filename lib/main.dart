import 'package:flutter/material.dart';
import 'package:le_bolide/src/features/Pages/Home/Pay/Pages/checkout3_page.dart';
import 'package:le_bolide/src/features/Pages/Home/Pay/Pages/checkout_page.dart';
import 'package:le_bolide/src/features/Pages/registration/pages/pages.dart';
import 'package:le_bolide/src/features/Pages/splash_screen/pages/splash_screen_page.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
 

    return Sizer(
      builder: (context, orientation, deviceType) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Pay3Page(),
        );
      },
    );
  }
}
