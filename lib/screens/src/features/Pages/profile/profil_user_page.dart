import 'package:Bolide/data/services/user.dart';
import 'package:Bolide/screens/src/features/Pages/profile/pages/pages.dart';
import 'package:Bolide/screens/src/features/Pages/registration/pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sizer/sizer.dart';

class UserProfilePage extends StatefulWidget {
  final int userId;
  final int partId;

  UserProfilePage({super.key, required this.partId, required this.userId}) {
    initializeDateFormatting('fr_FR', null);
  }

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late User user;
  final _formKey = GlobalKey<FormState>();

  final _surnameController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    try {
      user = GetIt.instance.get<User>();
      print(
          'Utilisateur récupéré: ${user.name}, ${user.surname}, ${user.phone}, ${user.id}');

      // Initialiser les contrôleurs avec les données utilisateur
      _surnameController.text = user.surname;
      _nameController.text = user.name;
      _phoneController.text = user.phone;
    } catch (e) {
      print('Erreur lors de la récupération de l\'utilisateur : $e');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              RegistrationPage(userId: widget.userId, partId: widget.partId),
        ),
      );
    }
  }

  Future<void> _updateUserInfo() async {
    print('Début de la mise à jour des informations utilisateur');

    // Récupérer les valeurs actuelles des contrôleurs
    final newSurname = _surnameController.text;
    final newName = _nameController.text;
    final newPhone = _phoneController.text;

    // Préparer les données à envoyer, en incluant toujours tous les champs
    final dataToSend = <String, dynamic>{
      'surname': newSurname.isNotEmpty ? newSurname : user.surname,
      'name': newName.isNotEmpty ? newName : user.name,
      'phone': newPhone.isNotEmpty ? newPhone : user.phone,
    };

    final url =
        'https://bolide.armasoft.ci/bolide_services/index.php/api/auth/update/${user.id}';
    print('URL de la requête : $url');
    print('Données envoyées : $dataToSend');

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(dataToSend),
    );

    print('Réponse de la requête : ${response.statusCode}');
    print('Corps de la réponse : ${response.body}');

    if (response.statusCode == 200) {
      print('Mise à jour réussie');
      // Afficher un message de succès ou faire autre chose en cas de succès
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: const Color(0xFF1A1A1A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 40.0,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Informations modifiées avec succès',
                    style: TextStyle(
                      fontFamily: 'Cabin',
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      print('Échec de la mise à jour');
      // Afficher un message d'erreur en cas d'échec
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: const Color(0xFF1A1A1A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    color: Colors.white,
                    size: 40.0,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Erreur lors de la mise à jour des informations',
                    style: TextStyle(
                      fontFamily: 'Cabin',
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Cabin'),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(2.h),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFEBEBEB),
                  ),
                  padding: EdgeInsets.all(0.w),
                  child: Image.asset(
                    'assets/icons/close.png',
                    width: 12.w,
                    height: 12.w,
                    color: Colors.black,
                  ),
                ),
              ),
              Gap(2.h),
              const Text(
                'Modifier mon profil',
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'Cabin',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1F1F1F),
                ),
              ),
              Gap(3.h),
              const Text(
                'Information personnelles',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Cabin',
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF1F1F1F),
                ),
              ),
              Divider(color: Colors.grey[600]),
              Gap(1.h),
              Row(
                children: [
                  Text(
                    'Prénom ',
                    style: TextStyle(
                      color: const Color(0xFF737373),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
              Gap(1.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1.h),
                  border: Border.all(color: const Color(0xFF1A1A1A)),
                ),
                child: TextFormField(
                  controller: _surnameController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(fontFamily: 'Cabin'),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(2.w),
                    hintText: 'Entrez votre prénom',
                  ),
                  style: TextStyle(
                    fontFamily: 'Cabin',
                    fontSize: 12.sp,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le prénom est requis';
                    }
                    return null;
                  },
                ),
              ),
              Gap(1.h),
              Row(
                children: [
                  Text(
                    'Nom ',
                    style: TextStyle(
                      color: const Color(0xFF737373),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
              Gap(1.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1.h),
                  border: Border.all(color: const Color(0xFF1A1A1A)),
                ),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(fontFamily: 'Cabin'),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(2.w),
                    hintText: 'Entrez votre nom',
                  ),
                  style: TextStyle(
                    fontFamily: 'Cabin',
                    fontSize: 12.sp,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le nom est requis';
                    }
                    return null;
                  },
                ),
              ),
              Gap(1.h),
              Row(
                children: [
                  Text(
                    'Téléphone ',
                    style: TextStyle(
                      color: const Color(0xFF737373),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
              Gap(1.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1.h),
                  border: Border.all(color: const Color(0xFF1A1A1A)),
                ),
                child: TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(fontFamily: 'Cabin'),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(2.w),
                    hintText: 'Entrez votre téléphone',
                  ),
                  style: TextStyle(
                    fontFamily: 'Cabin',
                    fontSize: 12.sp,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le téléphone est requis';
                    }
                    return null;
                  },
                ),
              ),
              Gap(70.w),
              // Ajout du bouton directement après les champs de saisie
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _updateUserInfo();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A1A1A),
                      foregroundColor:
                          Colors.white, // Couleur du texte en blanc
                      padding: EdgeInsets.symmetric(
                          vertical: 1.5.h, horizontal: 18.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.5.w),
                      ),
                    ),
                    child: Text(
                      'Terminer',
                      style: TextStyle(
                        fontFamily: 'Cabin',
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 2.h), // Espacement sous le bouton
            ],
          ),
        ),
      ),
    );
  }
}
