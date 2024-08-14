import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:Bolide/data/services/data_services.dart';
import 'package:Bolide/data/services/user.dart';
import 'package:Bolide/screens/src/features/Pages/Home/pages/home_page.dart';
import 'package:Bolide/screens/src/features/Pages/registration/pages/pages.dart';
import 'package:sizer/sizer.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'registration_last_page.dart';

class RegistrationAuthPage extends StatefulWidget {
  final int partId;
  final int userId;
  final String iconPath; // Nouvelle propriété pour l'icône
  final String phoneNumber;
  final String flag; // Flag parameter

  const RegistrationAuthPage({
    Key? key,
    required this.phoneNumber,
    required this.partId,
    required this.userId,
    required this.flag,
    required this.iconPath, // Required iconPath parameter
  }) : super(key: key);

  @override
  _RegistrationAuthPageState createState() => _RegistrationAuthPageState();
}

class _RegistrationAuthPageState extends State<RegistrationAuthPage> {
  final TextEditingController _pinController = TextEditingController();
  String _errorMessage = '';
  bool _isLoading = false;
  late final User user;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    try {
      user = GetIt.instance.get<User>();
      print(user.name);
      print('User information retrieved');
    } catch (e) {
      print(e);
      // Handle the error appropriately if user retrieval fails
    }
  }

  Future<void> _verifyOTP(String otp) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final url = Uri.parse(
      'https://bolide.armasoft.ci/bolide_services/index.php/api/otp/validate',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': widget.phoneNumber,
          'otp': otp,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        bool isRegistered = responseData['is_registered'];
        String message = responseData['message'] ?? '';

        if (isRegistered) {
          Map<String, dynamic> dataUser = json.decode(response.body);
          Map<String, dynamic> userData = dataUser['user_info'];

          int userId = int.tryParse(userData['id'].toString()) ?? 0;
          String userName = userData['name'] ?? '';
          String surname = userData['surname'] ?? '';
          String phone = userData['phone'] ?? '';

          User newUser = User(
            id: userId,
            name: userName,
            surname: surname,
            phone: phone,
          );

          await DataService.save("user", newUser.toJson().toString());
          GetIt.instance.registerFactory<User>(() => newUser);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(
                partId: widget.partId,
                userId: userId,
              ),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (_, __, ___) => RegistrationLastPage(
                phoneNumber: widget.phoneNumber,
                partId: widget.partId,
                userId: widget.userId,

                flag: widget.flag,
                iconPath: widget.iconPath, // Pass the flag to the next page
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
        }
      } else {
        setState(() {
          _errorMessage = 'Server error. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Connection error. Please try again.';
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 6.h),
              _buildHeader(),
              SizedBox(height: 5.h),
              _buildTitle(),
              SizedBox(height: 2.h),
              _buildPhoneNumberText(),
              SizedBox(height: 4.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 2.h),
                      _buildPinInput(),
                      SizedBox(height: 2.h),
                      if (_isLoading) const ImageRotation(),
                      if (_errorMessage.isNotEmpty) _buildErrorMessage(),
                      SizedBox(height: 4.h),
                      _buildResendOptions(),
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

  Widget _buildHeader() {
    return Row(
      children: [
        SizedBox(width: 4.w),
        _buildBackButton(),
        SizedBox(width: 35.w),
        Image.asset(
          'assets/icons/lgo.png',
          height: 4.h,
          fit: BoxFit.contain,
        ),
        const Spacer(flex: 3),
      ],
    );
  }

  Widget _buildBackButton() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RegistrationPage(
              partId: widget.partId,
              userId: widget.userId,
            ),
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
    );
  }

  Widget _buildTitle() {
    return Text(
      "Authentification",
      style: TextStyle(
        color: Colors.black,
        fontSize: 19.sp,
        fontFamily: "Poppins",
        letterSpacing: 0.05,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPhoneNumberText() {
    return Text.rich(
      TextSpan(
        text: "Un SMS sera envoyé au ",
        style: TextStyle(
          fontSize: 12.sp,
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
    );
  }

  Widget _buildPinInput() {
    return Pinput(
      controller: _pinController,
      length: 4,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      onCompleted: (pin) {
        print('PIN complete: $pin');
        _verifyOTP(pin);
      },
      defaultPinTheme: PinTheme(
        width: 60,
        height: 60,
        textStyle: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Text(
      _errorMessage,
      style: TextStyle(
        color: Colors.red,
        fontSize: 12.sp,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildResendOptions() {
    return Text.rich(
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
            text: "Modifier le numéro de téléphone",
            style: TextStyle(
              color: const Color(0xFF1A1A1A),
              fontWeight: FontWeight.bold,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
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
