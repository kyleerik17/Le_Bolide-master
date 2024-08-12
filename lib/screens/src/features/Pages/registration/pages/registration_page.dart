import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../../../data/models/api_services.dart';
import '../../Onboarding/pages/pages.dart';
import 'pages.dart';

class RegistrationPage extends StatefulWidget {
  final int userId;
  final int partId;

  const RegistrationPage({Key? key, required this.userId, required this.partId})
      : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCountry = 'Senegal';
  bool _isLoading = false;
  bool _isPhoneValid = false;
  final Map<String, String> _countryCodes = {
    'Senegal': '221',
    'Côte d\'Ivoire': '225',
  };

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  bool _isPhoneNumberValid(String phoneNumber) {
    print('Validation du numéro: $phoneNumber pour le pays: $_selectedCountry');
    if (_selectedCountry == 'Senegal') {
      bool valid = phoneNumber.length == 9 && phoneNumber.startsWith('7');
      print('Validation pour Sénégal: $valid');
      return valid;
    } else if (_selectedCountry == 'Côte d\'Ivoire') {
      bool valid = phoneNumber.length == 10 &&
          (phoneNumber.startsWith('05') ||
              phoneNumber.startsWith('01') ||
              phoneNumber.startsWith('07'));
      print('Validation pour Côte d\'Ivoire: $valid');
      return valid;
    }
    print('Validation échouée pour le pays sélectionné.');
    return false;
  }

  Future<void> _generateOTP() async {
    final phoneNumber = _phoneController.text.trim();

    if (!_isPhoneNumberValid(phoneNumber)) {
      _showErrorDialog('Numéro de téléphone invalide pour $_selectedCountry.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('${baseUrl}api/otp/generate');
    final fullPhoneNumber = '${_countryCodes[_selectedCountry]}$phoneNumber';
    final iconPath = _selectedCountry == 'Senegal'
        ? 'assets/icons/sng.png'
        : 'assets/icons/civ.png';

    print('Numéro complet envoyé à l\'API: $fullPhoneNumber');
    print('Icône sélectionnée: $iconPath');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': fullPhoneNumber}),
      );

      print('Code de statut de la réponse: ${response.statusCode}');
      print('Réponse brute de l\'API: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Réponse décodée: $responseData');

        await Future.delayed(const Duration(seconds: 1));

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (_, __, ___) => RegistrationAuthPage(
              phoneNumber: fullPhoneNumber,
              flag: _selectedCountry == 'Senegal' ? 'sng' : 'civ',
              userId: widget.userId,
              partId: widget.partId,
              iconPath: iconPath,
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
        print('Erreur lors de la requête: ${response.statusCode}');
        _showErrorDialog('Erreur de la demande OTP.');
      }
    } on SocketException {
      print('Erreur: problème de connexion Internet');
      _showErrorDialog('Vérifiez votre connexion Internet.');
    } catch (e) {
      print('Erreur lors de la connexion: $e');
      _showErrorDialog('Erreur: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
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
                          pageBuilder: (_, __, ___) =>
                              OnboardingPage(partId: 0, userId: widget.userId),
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
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: DropdownButton<String>(
                                value: _selectedCountry,
                                items: _countryCodes.keys.map((String country) {
                                  return DropdownMenuItem<String>(
                                    value: country,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          'assets/icons/${country == 'Senegal' ? 'sng' : 'civ'}.png',
                                          width: 5.w,
                                          height: 5.w,
                                        ),
                                        SizedBox(width: 1.w),
                                        Text(
                                          '+${_countryCodes[country]}',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontFamily: "Cabin",
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  print('Pays sélectionné: $newValue');
                                  setState(() {
                                    _selectedCountry = newValue!;
                                    _isPhoneValid = _isPhoneNumberValid(
                                        _phoneController.text.trim());
                                    _updatePhoneFormatter();
                                  });
                                },
                                icon: Icon(Icons.arrow_drop_down,
                                    color: Colors.black),
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12.sp),
                                underline:
                                    Container(), // Supprime le soulignement
                                dropdownColor: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _phoneController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Numéro de téléphone",
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 3.w,
                                    horizontal: 2.w,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(
                                      _getMaxLength()),
                                ],
                                textCapitalization: TextCapitalization.none,
                                onChanged: (text) {
                                  setState(() {
                                    _isPhoneValid =
                                        _isPhoneNumberValid(text.trim());
                                  });
                                },
                              ),
                            ),
                            if (_isPhoneValid)
                              Padding(
                                padding: EdgeInsets.all(2.w),
                                child: Image.asset(
                                  'assets/icons/check.png',
                                  width: 5.w,
                                  height: 5.w,
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (!_isPhoneValid && _phoneController.text.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            _selectedCountry == 'Côte d\'Ivoire'
                                ? 'Les numéros doivent commencer par 05, 01 ou 07 et avoir 10 chiffres.'
                                : 'Le numéro doit commencer par 7 et avoir 9 chiffres.',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 10.sp,
                            ),
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
                          onPressed: _isLoading || !_isPhoneValid
                              ? null
                              : () async {
                                  if (_isPhoneValid) {
                                    await _generateOTP();
                                  } else {
                                    print('Numéro de téléphone invalide.');
                                    _showErrorDialog(
                                        'Numéro de téléphone invalide.');
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A1A1A),
                            padding: EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 10.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  height: 2.h,
                                  width: 2.h,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.0,
                                  ),
                                )
                              : Text(
                                  'Suivant',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors
                                          .white), // Le texte du bouton est maintenant en blanc
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

  int _getMaxLength() {
    return _selectedCountry == 'Senegal' ? 9 : 10;
  }

  void _updatePhoneFormatter() {
    final maxLength = _getMaxLength();
    final formatter = LengthLimitingTextInputFormatter(maxLength);

    _phoneController.text = _phoneController.text.substring(
      0,
      min(_phoneController.text.length, maxLength),
    );
    _phoneController.selection = TextSelection.fromPosition(
      TextPosition(offset: _phoneController.text.length),
    );
  }
}
