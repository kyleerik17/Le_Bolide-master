import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:le_bolide/data/models/api_services.dart';
import 'package:le_bolide/data/services/user.dart';
import 'package:le_bolide/screens/src/features/Pages/registration/pages/registration-auth_page.dart';

import 'package:le_bolide/screens/src/features/Pages/registration/pages/registration_congratulation_page.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class RegistrationLastPage extends StatefulWidget {
  final int partId;
  final int userId;
  final String phoneNumber;
  final String flag;

  const RegistrationLastPage({
    Key? key,
    required this.phoneNumber,
    required this.partId,
    required this.userId,
    required this.flag,
  }) : super(key: key);

  @override
  _RegistrationLastPageState createState() => _RegistrationLastPageState();
}

class _RegistrationLastPageState extends State<RegistrationLastPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  String? nameError;
  String? surnameError;
  bool isLoading = false;

  @override
  void initState() {
    try {
      user = GetIt.instance.get<User>();

      print(user.name);
      print('user info');
    } catch (e) {
      print(e);
    }
    super.initState();
    phoneNumberController.text = widget.phoneNumber;
    print("InitState: Phone number set to ${widget.phoneNumber}");
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  String? validateName(String? value) {
    print("Validating name: $value");
    if (value == null || value.isEmpty) {
      return 'Ce champ est requis';
    }
    final regex = RegExp(r'^[a-zA-ZÀ-ÿ\s-]+$');
    if (!regex.hasMatch(value)) {
      return 'Le nom ne peut contenir que des lettres, espaces et tirets';
    }
    return null;
  }

  Future<void> registerUser() async {
    if (!_validateForm()) {
      print("Form validation failed");
      return;
    }

    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
        'https://bolide.armasoft.ci/bolide_services/index.php/api/auth/register');

    try {
      final String name = nameController.text.trim();
      final String surname = surnameController.text.trim();
      final String phone =
          phoneNumberController.text.replaceAll(RegExp(r'[^\d]'), '');

      final requestBody = {
        'phone': phone,
        'name': name,
        'surname': surname,
      };

      print("Request body: ${jsonEncode(requestBody)}");

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print("Response decoded: ${responseBody}");

        if (responseBody['message'] == 'Inscription reussie') {
          final data = responseBody['data'];
          final userId = data['id'];

          print("User ID: $userId");

          final user = User(
            id: userId,
            name: name,
            surname: surname,
            phone: phone,
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RegistrationCongratulationPage(
                phoneNumber: phone,
                partId: widget.partId,
                userId: user.id,
              ),
            ),
          );
        } else {
          print("Error message: ${responseBody['message']}");
          _showErrorSnackBar(
              'Erreur lors de l\'inscription. Veuillez réessayer.');
        }
      } else {
        print("Server error: ${response.statusCode}");
        _showErrorSnackBar('Erreur serveur. Veuillez réessayer plus tard.');
      }
    } catch (e) {
      print("Exception: $e");
      _showErrorSnackBar(
          'Erreur de connexion. Vérifiez votre connexion internet.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    print("Showing error snackbar: $message");
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  bool _validateForm() {
    setState(() {
      nameError = validateName(nameController.text);
      surnameError = validateName(surnameController.text);
    });
    print("Name error: $nameError");
    print("Surname error: $surnameError");
    return nameError == null && surnameError == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            children: [
              SizedBox(height: 6.h),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationAuthPage(
                            phoneNumber: widget.phoneNumber,
                            partId: widget.partId,
                            userId: widget.userId,
                            flag: widget.flag,
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
                  ),
                  SizedBox(width: 20.w),
                  Image.asset(
                    'assets/icons/lgo.png',
                    height: 4.h,
                    width: 40.w,
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
                      SizedBox(height: 4.h),
                      Image.asset(
                        'assets/icons/il.png',
                        width: 15.w,
                        height: 15.h,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'Inscription',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: "Cabin",
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'Veuillez entrer vos nom(s) et prénom(s) ainsi\nque votre date de naissance',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "Cabin",
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 3.h),
                      _buildTextField(
                        controller: phoneNumberController,
                        hintText: 'Téléphone',
                        readOnly: true,
                      ),
                      SizedBox(height: 3.h),
                      _buildTextField(
                        controller: nameController,
                        hintText: 'Nom',
                        errorText: nameError,
                      ),
                      SizedBox(height: 3.h),
                      _buildTextField(
                        controller: surnameController,
                        hintText: 'Prénom',
                        errorText: surnameError,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5.w),
              Center(
                child: ElevatedButton(
                  onPressed: isLoading ? null : registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    padding:
                        EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.5.w),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "Suivant",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontFamily: "Cabin",
                              fontWeight: FontWeight.w600),
                        ),
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool readOnly = false,
    String? errorText,
  }) {
    return Container(
      width: 358,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFC9CDD2),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          hintText: hintText,
          errorText: errorText,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/icons/crt.png'),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 3.0),
        ),
      ),
    );
  }
}
