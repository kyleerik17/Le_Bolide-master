import 'package:flutter/material.dart';
import 'package:le_bolide/data/models/api_services.dart';
import 'package:sizer/sizer.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'pages.dart';

class RegistrationAuthPage extends StatefulWidget {
  final String phoneNumber;

  const RegistrationAuthPage({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  _RegistrationAuthPageState createState() => _RegistrationAuthPageState();
}

class _RegistrationAuthPageState extends State<RegistrationAuthPage> {
  final TextEditingController _pinController = TextEditingController();
  String _errorMessage = '';

  Future<void> _verifyOTP(String otp) async {
    final url = Uri.parse('${baseUrl}api/otp/validate');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': widget.phoneNumber, // Ajout du numéro de téléphone
          'otp': otp,
        }),
        
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (_, __, ___) => RegistrationLastPage(
              phoneNumber: widget.phoneNumber, // Passer le numéro de téléphone
            ),
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
      } else {
        setState(() {
          _errorMessage = 'Le code OTP est incorrect ou a expiré.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur de connexion. Veuillez réessayer.';
      });
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                          pageBuilder: (_, __, ___) => RegistrationPage(),
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
                      SizedBox(height: 15.w),
                      Image.asset(
                        'assets/icons/check.png',
                        width: 20.w,
                        height: 20.w,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'Vérification',
                        style: TextStyle(
                          fontSize: 21.sp,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Entrez le code de vérification envoyé à votre numéro ${widget.phoneNumber}.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "Cabin",
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 2.h),
                      Pinput(
                        controller: _pinController,
                        length: 4, // Changer la longueur à 4
                        onChanged: (value) {
                          setState(() {
                            _errorMessage = '';
                          });
                        },
                      ),
                      SizedBox(height: 2.h),
                      if (_errorMessage.isNotEmpty)
                        Text(
                          _errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      SizedBox(height: 20.h),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => _verifyOTP(_pinController.text),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A1A1A),
                            padding: EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 10.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1.h),
                            ),
                          ),
                          child: Text(
                            "Vérifier",
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
