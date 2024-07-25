import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../../../data/models/api_services.dart';
import '../../Onboarding/pages/pages.dart';
import 'pages.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _generateOTP() async {
    final url = Uri.parse('${baseUrl}api/otp/generate');
    final phoneNumber = _phoneController.text.trim();

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phoneNumber}),
      );

      // Afficher la réponse dans la console
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (_, __, ___) => RegistrationAuthPage(
              phoneNumber: phoneNumber, // Passez le numéro de téléphone ici
            ),
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
      } else {
        _showErrorDialog('Une erreur est survenue lors de la génération du code OTP.');
      }
    } catch (e) {
      _showErrorDialog('Erreur de connexion. Veuillez réessayer.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erreur'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 6.h),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 300),
                          pageBuilder: (_, __, ___) => const OnboardingPage(),
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
              SizedBox(height: 3.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20.w),
                      Image.asset(
                        'assets/icons/tel.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'Entrer votre numéro mobile',
                        style: TextStyle(
                          fontSize: 21.sp,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'Numéro mobile',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "Cabin",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(0.w),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(width: 1.5.h),
                                  Image.asset(
                                    'assets/icons/sng.png',
                                    width: 5.w,
                                    height: 5.w,
                                  ),
                                  SizedBox(width: 2.w),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 3.w),
                              child: Text(
                                '+221 ',
                                style: TextStyle(
                                  color: const Color(0xFF1A1A1A),
                                  fontFamily: 'Cabin',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _phoneController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "78 444 56 78",
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 3.w,
                                  ),
                                ),
                                keyboardType: TextInputType.phone,
                                textCapitalization: TextCapitalization.none,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/icons/check.png',
                                    width: 5.w,
                                    height: 5.w,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text.rich(
                        TextSpan(
                          text: "En continuant, vous acceptez ",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: "Cabin",
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: "nos conditions générales d'utilisations",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ".",
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.h),
                      Center(
                        child: ElevatedButton(
                          onPressed: _generateOTP,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A1A1A),
                            padding: EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 10.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1.h),
                            ),
                          ),
                          child: Text(
                            "Suivant",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontFamily: "Cabin",
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
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

