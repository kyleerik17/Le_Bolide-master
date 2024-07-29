import 'package:flutter/material.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/Pay/Pages/checkout1_page.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/pages/home_page.dart';
import 'package:le_bolide/screens/src/features/Pages/registration/pages/pages.dart';
import 'package:le_bolide/screens/src/features/Pages/registration/pages/registration_congratulation_page.dart';
import 'package:le_bolide/screens/src/features/Pages/registration/pages/registration_page.dart';
import 'package:le_bolide/screens/src/features/Pages/splash_screen/pages/splash_screen_page.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp(userId: 1, partId: 1)); // Vous pouvez ajuster ces valeurs par défaut
}

class MyApp extends StatelessWidget {
  final int userId;
  final int partId;

  const MyApp({super.key, required this.userId, required this.partId});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: RegistrationPage(
            partId: partId,
            userId: userId, 
          ),
        );
      },
    );
  }
}