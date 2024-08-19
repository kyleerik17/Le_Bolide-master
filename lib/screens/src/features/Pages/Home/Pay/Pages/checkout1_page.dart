import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:Bolide/data/services/user.dart'; // Assurez-vous que ce chemin est correct
import 'package:Bolide/screens/src/features/Pages/Home/Pay/Pages/checkout2_page.dart';
import 'package:Bolide/screens/src/features/Pages/Home/Pay/Pages/checkout_page.dart';
import 'package:Bolide/screens/src/features/Pages/Home/Pay/Pages/checkout3_page.dart';
import 'package:sizer/sizer.dart';
import '../Widgets/formulaire_livraison.dart';

class Pay1Page extends StatefulWidget {
  final int partId;
  final String deliveryAddress;
  final List<Map<String, dynamic>> cartItems;

  Pay1Page({
    Key? key,
    required this.partId,
    required this.cartItems,
    required this.deliveryAddress,
    required int userId,
  }) : super(key: key);

  @override
  _Pay1PageState createState() => _Pay1PageState();
}

class _Pay1PageState extends State<Pay1Page> {
  bool _isLoading = false;
  late User user; // Déclaration de la variable user

  String _name = '';
  String _surname = '';
  String _email = '';
  String _country = '';
  String _address = '';

  @override
  void initState() {
    super.initState();
    user = GetIt.instance.get<User>(); // Récupération de l'utilisateur
    print('Pay1Page - Initial user id: ${user.id}'); // Affichage du user.id
    print('Pay1Page - Initial partId: ${widget.partId}');
    print('Pay1Page - Initial deliveryAddress: ${widget.deliveryAddress}');
    print('Pay1Page - Initial cartItems: ${widget.cartItems}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            print(
                'Navigating to PayPage with partId: ${widget.partId}, userId: ${user.id}, cartItems: ${widget.cartItems}');
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    PayPage(
                  partId: widget.partId,
                  userId: user.id, // Utilisation de user.id
                  cartItems: widget.cartItems,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const offsetBegin = Offset(-1.0, 0.0); // Start from right
                  const offsetEnd = Offset.zero; // End at the current position
                  const curve = Curves.easeInOutCubic; // Courbe plus fluide

                  var tween = Tween(begin: offsetBegin, end: offsetEnd)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                      position: offsetAnimation, child: child);
                },
              ),
            );
          },
          child: Image.asset(
            'assets/icons/gc.png',
            width: 15.w,
            height: 15.w,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFF7F8F9),
        elevation: 0,
        title: Text(
          'Paiement',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/icons/lgo.png',
                      width: 8.w,
                    ),
                    // SizedBox(width: 40.w),
                    Row(
                      children: [
                       SvgPicture.asset(
                            'assets/icons/lock.svg',
                            width: 16,
                            height: 16,
                            color: Colors.black,
                          ),
                        SizedBox(width: 2.w),
                        Text(
                          'Paiement sécurisé',
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  SizedBox(width: 2.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.2.w),
                    child:SvgPicture.asset(
                           
                                'assets/icons/cs1.svg',
                            width: 7.w,
                            height: 7.w,
                          ),
                  ),
                  SizedBox(
                    width: 30.w,
                    child: const Divider(
                      color: Colors.grey,
                      thickness: 2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.2.w),
                    child:SvgPicture.asset(
                           
                                'assets/icons/cs2.svg',
                            width: 7.w,
                            height: 7.w,
                          ),
                  ),
                  SizedBox(
                    width: 33.w,
                    child: const Divider(
                      color: Colors.grey,
                      thickness: 2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.2.w),
                    child: SvgPicture.asset(
                           
                                'assets/icons/cs2.svg',
                            width: 7.w,
                            height: 7.w,
                          ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStep('  Livraison'),
                  _buildStep('Paiement'),
                  _buildStep('Confirmation'),
                ],
              ),
              SizedBox(height: 2.h),
              Text(
                "Ajoutez votre adresse de livraison",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                "* Champs obligatoires",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Cabin",
                ),
              ),
              // Formulaire de livraison
              FormulaireLivraison(
                userId: user.id, // Utilisation de user.id
                partId: widget.partId,
                onInformationChanged: (name, surname, email, country, address) {
                  setState(() {
                    _name = name;
                    _surname = surname;
                    _email = email;
                    _country = country;
                    _address = address;
                    print(
                        'Information changed: name: $_name, surname: $_surname, email: $_email, country: $_country, address: $_address');
                  });
                },
              ),
              SizedBox(height: 4.h),
              Center(
                child: TextButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          if (_validateFields()) {
                            setState(() {
                              _isLoading = true;
                            });

                            // Créer une liste de détails de commande
                            List<Map<String, String>> orderDetails = [
                              {
                                'name': _name,
                                'surname': _surname,
                                'email': _email,
                                'country': _country,
                                'address': _address,
                              }
                            ];

                            print('Order details: $orderDetails');

                            // Attendre avant de naviguer vers la page suivante
                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      Pay2Page(
                                    partId: widget.partId,
                                    deliveryAddress: widget.deliveryAddress,
                                    cartItems: widget.cartItems,
                                    userId: user.id, // Passer user.id
                                    orderDetails: orderDetails,
                                  ),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const offsetBegin = Offset(
                                        1.0, 0.0); // Commence de la gauche
                                    const offsetEnd = Offset
                                        .zero; // Finit à la position actuelle
                                    const curve = Curves
                                        .easeInOutCubic; // Courbe plus fluide

                                    var tween = Tween(
                                            begin: offsetBegin, end: offsetEnd)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation =
                                        animation.drive(tween);

                                    return SlideTransition(
                                        position: offsetAnimation,
                                        child: child);
                                  },
                                ),
                              ).then((_) {
                                setState(() {
                                  _isLoading = false;
                                });
                              });
                            });
                          }
                        },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    padding:
                        EdgeInsets.symmetric(vertical: 0.h, horizontal: 20.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.w),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_isLoading)
                        SizedBox(
                          height: 1.h,
                          width: 2.h,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.0,
                          ),
                        ),
                      if (!_isLoading)
                        Text(
                          "Continuer",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontFamily: 'Cabin',
                            fontWeight: FontWeight.w500,
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

  bool _validateFields() {
    if (_name.isEmpty ||
        _surname.isEmpty ||
        _email.isEmpty ||
        _country.isEmpty ||
        _address.isEmpty) {
      _showErrorDialog('Tous les champs doivent être remplis.');
      return false;
    }

    final emailRegExp =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegExp.hasMatch(_email)) {
      _showErrorDialog('Veuillez entrer une adresse email valide.');
      return false;
    }

    final addressRegExp = RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z]).{5,}$');
    if (!addressRegExp.hasMatch(_address)) {
      _showErrorDialog(
          'Veuillez entrer une adresse valide. Elle doit contenir des lettres, des chiffres, et avoir au moins 5 caractères.');
      return false;
    }

    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erreur'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

Widget _buildStep(String title) {
  return Row(
    children: [
      Text(
        title,
        style: TextStyle(fontSize: 11.sp),
      ),
    ],
  );
}
