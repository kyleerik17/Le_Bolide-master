import 'package:Bolide/screens/src/features/Pages/Home/Menu/pages/menu_page.dart';
import 'package:Bolide/screens/src/features/Pages/profile/profil_user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:Bolide/core/di/service_locator.dart';
import 'package:Bolide/data/services/user.dart';
import 'package:Bolide/screens/src/features/Pages/registration/pages/registration_page.dart';
import 'package:sizer/sizer.dart';

import '../../Home/pages/home_page.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final int partId;
  final int userId;

  const ProfilePage(
    this.partId,
    this.userId, {
    Key? key,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late User user;

  @override
  void initState() {
    super.initState();
    try {
      user = GetIt.instance.get<User>();
      print(user.name);
      print('user info');
    } catch (e) {
      print(e);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              RegistrationPage(userId: widget.userId, partId: widget.partId),
        ),
      );
    }
    // Configure la barre d'état pour Android
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF1A1A1A),
      statusBarIconBrightness: Brightness.light,
    ));
  }

  String _getInitials(String name, String surname) {
    // Prend la première lettre du prénom et du nom de famille
    return '${name.isNotEmpty ? name[0] : ''}${surname.isNotEmpty ? surname[0] : ''}'
        .toUpperCase();
  }

  String _getFormattedPhone(String phone) {
    String indicatif = '';
    String numero = '';

    if (phone.startsWith('+')) {
      indicatif = phone.substring(0, 4);
      numero = phone.substring(4);
    } else {
      indicatif = phone.substring(0, 3);
      numero = phone.substring(3);
    }

    return '$indicatif $numero';
  }

  void _confirmSignOut() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Confirmer la déconnexion',
              style: TextStyle(
                fontFamily: 'Cabin',
                fontSize: 18.sp,
              ),
            ),
          ),
          content: Text(
            'Êtes-vous sûr de vouloir vous déconnecter ?',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13.sp,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Arrondi des coins
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 2), // Agrandit le background
                    ),
                    child: Text(
                      'Annuler',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15.sp,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Ferme la boîte de dialogue
                    },
                  ),
                  SizedBox(width: 5.w), // Ajoute un espace entre les boutons
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red, // Couleur de fond
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Arrondi des coins
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5), // Agrandit le background
                    ),
                    child: Text(
                      'Confirmer',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontSize: 15.sp,
                      ),
                    ),
                    onPressed: () {
                      // Supprime l'utilisateur de GetIt
                      GetIt.instance.unregister<User>();
                      // Navigue vers RegistrationPage
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationPage(
                              userId: widget.userId, partId: widget.partId),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        title: Text(
          'Profil',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(
                      milliseconds: 600), // Augmentez la durée de l'animation
                  pageBuilder: (_, __, ___) =>
                      HomePage(partId: widget.partId, userId: widget.userId),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const offsetBegin = Offset(1.0, 0.0); // Start from right
                    const offsetEnd =
                        Offset.zero; // End at the current position
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
            icon: Image.asset(
              'assets/icons/dt.png',
              height: 18.w,
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 15.0)),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(6.h),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 15.w,
                          height: 15.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1A1A1A),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              _getInitials(user.name,
                                  user.surname), // Utilisation des initiales
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Cabin',
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          '${user.name} ${user.surname}', // Ajoute un espace ici
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Cabin',
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (user.phone.startsWith('225') ||
                                user.phone.startsWith('+225'))
                              Image.asset(
                                'assets/icons/civ.png',
                                width: 5.w,
                                height: 5.w,
                              )
                            else if (user.phone.startsWith('221') ||
                                user.phone.startsWith('+221'))
                              Image.asset(
                                'assets/icons/sng.png',
                                width: 5.w,
                                height: 5.w,
                              ),
                            SizedBox(
                                width:
                                    2.w), // Espace entre l'icône et l'indicatif
                            Text(
                              _getFormattedPhone(user.phone),
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Cabin',
                                color: const Color(0xFF7F7F7F),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Gap(10.w),
              Padding(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(0.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 600),
                                    pageBuilder: (_, __, ___) =>
                                        UserProfilePage(
                                      userId: user.id,
                                      partId: widget.partId,
                                    ),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin =
                                          Offset(1.0, 0.0); // Start from right
                                      var end = Offset
                                          .zero; // End at the current position
                                      var curve = Curves.easeInOut;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);

                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Modifier profil",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Cabin',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Rest of the code

                    Gap(5.h),
                    Padding(
                      padding: EdgeInsets.all(0.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Notifications",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Cabin',
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(5.h),
                    Divider(
                      color: const Color(0xFFEAEAEA),
                      height: 1.h,
                      thickness: 2,
                    ),
                    Gap(10.w),
                    Padding(
                      padding: EdgeInsets.all(0.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Conditions d'utilisation",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Cabin',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(5.h),
                    Padding(
                      padding: EdgeInsets.all(0.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Politique de confidentialité",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Cabin',
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(5.h),
                    Divider(
                      color: const Color(0xFFEAEAEA),
                      height: 1.h,
                      thickness: 2,
                    ),
                    Gap(10.w),
                    Padding(
                      padding: EdgeInsets.all(0.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Signaler un bug",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Cabin',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(5.h),
                    Padding(
                      padding: EdgeInsets.all(0.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: _confirmSignOut,
                                  child: Text(
                                    "Déconnexion",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Cabin',
                                      color: const Color(0xFF1A1A1A),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(3.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
