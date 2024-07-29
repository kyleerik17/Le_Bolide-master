import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:le_bolide/screens/src/features/Pages/registration/pages/registration-auth_page.dart';
import 'package:le_bolide/screens/src/features/Pages/registration/pages/registration_congratulation_page.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../../../Widgets/inputs/inputs.dart';

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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  String? nameError;
  String? surnameError;
  String? emailError;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    phoneNumberController.text = widget.phoneNumber;
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est requis';
    }
    final regex = RegExp(r'^[a-zA-ZÀ-ÿ\s-]+$');
    if (!regex.hasMatch(value)) {
      return 'Le nom ne peut contenir que des lettres, espaces et tirets';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est requis';
    }
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!regex.hasMatch(value)) {
      return 'Veuillez entrer un email valide';
    }
    return null;
  }

  Future<void> registerUser() async {
    print('Bouton "Enregistrer" pressé');

    if (!_validateForm()) {
      print('Erreur de validation des données');
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
      final String email = emailController.text.trim();
      final String phone =
          phoneNumberController.text.replaceAll(RegExp(r'[^\d]'), '');

      final requestBody = {
        'phone': phone,
        'name': name,
        'surname': surname,
        'email': email,
      };

      print('Payload envoyé à l\'API: $requestBody');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print('Réponse de l\'API: ${response.body}');
      print('Code de statut: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print('Réponse décodée: $responseBody');

        if (responseBody['message'] == 'Inscription reussie') {
          final data = responseBody['data'];
          final userId = data['id'];
          final userName = data['name'];
          final userSurname = data['surname'];
          final userPhone = data['phone'];

          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (_, __, ___) => RegistrationCongratulationPage(
                partId: widget.partId,
                userId: userId, // Pass the userId from the API response
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
          _showErrorSnackBar(
              'Erreur lors de l\'inscription. Veuillez réessayer.');
        }
      } else {
        _showErrorSnackBar('Erreur serveur. Veuillez réessayer plus tard.');
      }
    } catch (e) {
      print('Erreur de connexion: $e');
      _showErrorSnackBar(
          'Erreur de connexion. Vérifiez votre connexion internet.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  bool _validateForm() {
    setState(() {
      nameError = validateName(nameController.text);
      surnameError = validateName(surnameController.text);
      emailError = validateEmail(emailController.text);
    });

    return nameError == null && surnameError == null && emailError == null;
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
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 300),
                          pageBuilder: (_, __, ___) => RegistrationAuthPage(
                            phoneNumber: widget.phoneNumber,
                            partId: widget.partId,
                            userId: widget.userId, flag: widget.flag,
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
                  Spacer(flex: 3),
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
                        'Veuillez entrer vos nom(s) et prénom(s) ainsi que votre date de naissance',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "Cabin",
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 1.5.h),
                      Row(
                        children: [
                          Image.asset(
                            widget.flag,
                            width: 50.0,
                            height: 50.0,
                          ),
                          const SizedBox(width: 16.0),
                          Text(
                            widget.phoneNumber,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      _buildTextField(
                        controller: nameController,
                        labelText: 'Nom',
                        errorText: nameError,
                      ),
                      const SizedBox(height: 16.0),
                      _buildTextField(
                        controller: surnameController,
                        labelText: 'Prénom',
                        errorText: surnameError,
                      ),
                      const SizedBox(height: 16.0),
                      _buildTextField(
                        controller: emailController,
                        labelText: 'Email',
                        errorText: emailError,
                      ),
                      const SizedBox(height: 30.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: registerUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A1A1A),
                            padding: EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 10.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1.5.w),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    String? errorText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
    );
  }
}
