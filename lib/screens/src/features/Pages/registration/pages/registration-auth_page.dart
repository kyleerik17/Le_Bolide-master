import 'package:flutter/material.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/pages/home_page.dart';
import 'package:sizer/sizer.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'pages.dart';

class RegistrationAuthPage extends StatefulWidget {
  final String phoneNumber;
  final int partId;
  final int userId;

  const RegistrationAuthPage(
      {Key? key,
      required this.phoneNumber,
      required this.partId,
      required this.userId,
      required String flag})
      : super(key: key);

  @override
  _RegistrationAuthPageState createState() => _RegistrationAuthPageState();
}

class _RegistrationAuthPageState extends State<RegistrationAuthPage> {
  final TextEditingController _pinController = TextEditingController();
  String _errorMessage = '';
  bool _isLoading = false;

  Future<void> _verifyOTP(String otp) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final url = Uri.parse(
        'https://bolide.armasoft.ci/bolide_services/index.php/api/otp/validate');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': widget.phoneNumber,
          'otp': otp,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response data: $responseData');

        if (responseData['statut'] == true) {
          print('OTP validation successful. Navigating to HomePage.');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(
                userId: widget.userId,
                partId: widget.partId,
              ),
            ),
          );
        } else {
          print('OTP validation failed. Navigating to RegistrationLastPage.');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => RegistrationLastPage(
                phoneNumber: widget.phoneNumber,
                partId: widget.partId,
                userId: widget.userId,
                flag: '',
              ),
            ),
          );
        }
      } else {
        setState(() {
          _errorMessage = 'Erreur de serveur. Veuillez réessayer.';
        });
      }
    } catch (e) {
      print('Error during OTP verification: $e');
      setState(() {
        _errorMessage = 'Erreur de connexion. Veuillez réessayer.';
      });
    } finally {
      setState(() {
        _isLoading = false;
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 6.h),
              Row(
                children: [
                  SizedBox(width: 4.w),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 300),
                          pageBuilder: (_, __, ___) => RegistrationPage(
                              partId: widget.partId, userId: widget.userId),
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
              SizedBox(height: 5.h),
              Text(
                "Authentification",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontFamily: "Poppins",
                  letterSpacing: 0.05,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2.h),
              Text.rich(
                TextSpan(
                  text: "Un SMS sera envoyé au ",
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: "Cabin",
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.phoneNumber,
                      style: const TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 2.h),
                      Pinput(
                        controller: _pinController,
                        length: 4,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        onChanged: (value) {
                          setState(() {
                            _errorMessage = '';
                          });
                          if (value.length == 4) {
                            _verifyOTP(value);
                          }
                        },
                      ),
                      SizedBox(height: 2.h),
                      if (_isLoading) const ImageRotation(),
                      if (_errorMessage.isNotEmpty)
                        Text(
                          _errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      SizedBox(height: 4.h),
                      Text.rich(
                        TextSpan(
                          text: "Vous n'avez pas reçu de code ? ",
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontFamily: "Cabin",
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Renvoyer \n",
                              style: TextStyle(
                                color: const Color(0xFF1A1A1A),
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp,
                              ),
                            ),
                            TextSpan(
                              text: "Recevoir un appel",
                              style: TextStyle(
                                color: const Color(0xFF1A1A1A),
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 3.h),
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

class ImageRotation extends StatefulWidget {
  const ImageRotation({Key? key}) : super(key: key);

  @override
  _ImageRotationState createState() => _ImageRotationState();
}

class _ImageRotationState extends State<ImageRotation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: -_controller.value * 2.0 * 3.141592653589793,
          child: Image.asset(
            'assets/icons/sp.png',
            width: 8.w,
            height: 8.h,
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}
