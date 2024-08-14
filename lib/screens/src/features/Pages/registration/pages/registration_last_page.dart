import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:Bolide/data/services/getit.dart';
import 'package:Bolide/data/services/user.dart';
import 'package:Bolide/screens/src/features/Pages/Home/pages/home_page.dart';
import 'package:Bolide/screens/src/features/Pages/registration/pages/registration-auth_page.dart';
import 'package:Bolide/screens/src/features/Pages/registration/pages/registration_congratulation_page.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class RegistrationLastPage extends StatefulWidget {
  final int partId;
  final int userId;
  final String phoneNumber;
  final String flag;
  final String iconPath; // Ajout du paramètre iconPath

  const RegistrationLastPage({
    Key? key,
    required this.phoneNumber,
    required this.partId,
    required this.userId,
    required this.flag,
    required this.iconPath, // Initialisation du paramètre iconPath
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
    super.initState();
    phoneNumberController.text = widget.phoneNumber;
    print(
        "InitState: Le numéro de téléphone est défini sur ${widget.phoneNumber}");
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
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

  Future<void> registerUser() async {
    if (!_validateForm()) {
      print("La validation du formulaire a échoué");
      return;
    }

    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
        'https://bolide.armasoft.ci/bolide_services/index.php/api/auth/register');

    final String name = nameController.text.trim();
    final String surname = surnameController.text.trim();
    final String phone =
        phoneNumberController.text.replaceAll(RegExp(r'[^\d]'), '');

    final requestBody = {
      'phone': phone,
      'name': name,
      'surname': surname,
    };

    print("Corps de la requête: ${jsonEncode(requestBody)}");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print("Statut de la réponse: ${response.statusCode}");
      print("Corps de la réponse: ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print("Réponse décodée: ${responseBody}");

        if (responseBody['message'] == 'Inscription reussie') {
          final data = responseBody['data'];
          final userId = data['id'];
          final userName = data['name'];
          final userSurname = data['surname'];
          final userPhone = data['phone'];

          print("ID Utilisateur: $userId");

          final user = User(
            id: userId,
            name: userName,
            surname: userSurname,
            phone: userPhone,
          );

          GetIt.instance.registerSingleton<User>(user);

          if (mounted) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    RegistrationCongratulationPage(
                  phoneNumber: phone,
                  userId: userId,
                  partId: widget.partId,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;
                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                      position: offsetAnimation, child: child);
                },
              ),
            );
          }
        } else {
          _showErrorDialog(responseBody['message']);
        }
      } else {
        _showErrorDialog('Erreur du serveur');
      }
    } on SocketException {
      _showErrorDialog('Vérifiez votre connexion');
    } catch (e) {
      print("Exception: $e");
      _showErrorDialog('Une erreur est survenue');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  bool _validateForm() {
    setState(() {
      nameError = validateName(nameController.text);
      surnameError = validateName(surnameController.text);
    });
    print("Erreur de nom: $nameError");
    print("Erreur de prénom: $surnameError");
    return nameError == null && surnameError == null;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Erreur'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
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
                            iconPath: widget.iconPath, // Passage de iconPath
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
                        isPhoneNumber: true,
                        flag: widget.flag,
                        iconPath: widget.iconPath, // Passer iconPath
                      ),
                      SizedBox(height: 3.h),
                      _buildTextField(
                        controller: nameController,
                        hintText: 'Nom(s)',
                        errorText: nameError,
                      ),
                      SizedBox(height: 3.h),
                      _buildTextField(
                        controller: surnameController,
                        hintText: 'Prénom(s)',
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
                      ? const SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          'SUIVANT',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    String? errorText,
    bool readOnly = false,
    bool isPhoneNumber = false,
    String? flag,
    String? iconPath,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 14.0),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 12.sp,
            color: Color(0xFF999999),
          ),
          errorText: errorText,
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Image.asset(
              isPhoneNumber && iconPath != null
                  ? iconPath
                  : 'assets/icons/crt.png',
              width: 6.w,
              height: 6.w,
              fit: BoxFit.contain,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
