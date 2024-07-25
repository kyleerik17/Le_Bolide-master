import 'package:flutter/material.dart';
import 'package:le_bolide/screens/src/features/Pages/registration/pages/registration-auth_page.dart';
import 'package:le_bolide/screens/src/features/Pages/registration/pages/registration_congratulation_page.dart';
import 'package:le_bolide/screens/src/features/Widgets/inputs/input_text.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../../../data/models/api_services.dart';

class RegistrationLastPage extends StatefulWidget {
  final String phoneNumber;

  const RegistrationLastPage({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  _RegistrationLastPageState createState() => _RegistrationLastPageState();
}

class _RegistrationLastPageState extends State<RegistrationLastPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String name = '';
  String surname = '';

  @override
  void initState() {
    super.initState();
    phoneController.text = widget.phoneNumber;

    nameController.addListener(() {
      setState(() {
        name = nameController.text;
      });
      print("Nom changé (listener): $name");
    });

    surnameController.addListener(() {
      setState(() {
        surname = surnameController.text;
      });
      print("Prénom changé (listener): $surname");
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    String phoneNumber = phoneController.text;

    print('Valeurs avant enregistrement :');
    print('Numéro de téléphone : "$phoneNumber"');
    print('Nom : "$name"');
    print('Prénom : "$surname"');

    // Appliquer trim() et vérifier à nouveau
    phoneNumber = phoneNumber.trim();
    name = name.trim();
    surname = surname.trim();

    print('Valeurs après trim() :');
    print('Numéro de téléphone : "$phoneNumber"');
    print('Nom : "$name"');
    print('Prénom : "$surname"');

    if (phoneNumber.isEmpty) {
      print('Le champ Numéro de téléphone est vide.');
      return;
    }
    if (name.isEmpty) {
      print('Le champ Nom est vide.');
      return;
    }
    if (surname.isEmpty) {
      print('Le champ Prénom est vide.');
      return;
    }

    final fullPhoneNumber = '+221$phoneNumber';
    final url = Uri.parse(
        '${baseUrl}api/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phone': fullPhoneNumber,
          'name': name,
          'surname': surname,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print('Données de la réponse : $responseBody');

        if (responseBody['name'] == name && responseBody['surname'] == surname && responseBody['phone'] == phoneNumber) {
          print('Les données renvoyées par l\'API sont correctes.');
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (_, __, ___) =>
                  const RegistrationCongratulationPage(),
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
          print('Les données renvoyées par l\'API ne correspondent pas.');
          // Affichez un message d'erreur à l'utilisateur ici
        }
      } else {
        print('Erreur : ${response.statusCode}');
        print('Données de la réponse : ${response.body}');
        // Affichez un message d'erreur à l'utilisateur ici
      }
    } catch (e) {
      print('Erreur lors de la requête : $e');
      // Affichez un message d'erreur à l'utilisateur ici
    }
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
                      InputText(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/icons/sng.png',
                                width: 5.w,
                              ),
                              SizedBox(width: 1.5.h),
                              Text(
                                widget.phoneNumber,
                                style: TextStyle(
                                  color: const Color(0xFF1A1A1A),
                                  fontFamily: 'Cabin',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        controller: phoneController,
                        enabled: false,
                      ),
                      SizedBox(height: 2.h),
                      InputText(
                        hintText: "Nom(s)",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/icons/crt.png',
                                width: 5.w,
                              ),
                              SizedBox(width: 1.5.h),
                            ],
                          ),
                        ),
                        controller: nameController,
                        onChanged: (value) {
                          setState(() {
                            name = value!;
                          });
                          print("Nom onChanged: $value");
                        },
                      ),
                      SizedBox(height: 2.h),
                      InputText(
                        hintText: "Prénom(s)",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(0.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/icons/crt.png',
                                width: 5.w,
                              ),
                              SizedBox(width: 1.5.h),
                            ],
                          ),
                        ),
                        controller: surnameController,
                        onChanged: (value) {
                          setState(() {
                            surname = value!;
                          });
                          print("Prénom onChanged: $value");
                        },
                      ),
                      SizedBox(height: 3.h),
                      ElevatedButton(
                        onPressed: registerUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A1A1A),
                          padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 10.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.5.w),
                          ),
                        ),
                        child: Text(
                          "Suivant",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontFamily: "Cabin",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
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