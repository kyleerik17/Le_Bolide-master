import 'package:flutter/material.dart';
import 'package:Bolide/screens/src/features/Pages/Home/pages/home_page.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../profile/pages/pages.dart';

class MenuPage extends StatefulWidget {
  final int partId;
  final int userId;

  const MenuPage({Key? key, required this.partId, required this.userId})
      : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<dynamic> socialLinks = [];

  @override
  void initState() {
    super.initState();
    _fetchSocialLinks();
  }

  Future<void> _fetchSocialLinks() async {
    final url =
        'https://bolide.armasoft.ci/bolide_services/index.php/api/social';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          socialLinks = data[
              'social_links']; // Supposons que l'API renvoie une liste de liens sociaux
        });
      } else {
        print('Erreur lors de la récupération des liens sociaux');
      }
    } catch (e) {
      print('Erreur: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: SizedBox(
        child: Container(
          color: const Color(0xFF1A1A1A),
          child: ListView(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 25.w),
                          Image.asset(
                            'assets/icons/home.png',
                            width: 45.w,
                            height: 13.w,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(9.w),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      ProfilePage(widget.partId, widget.userId),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 300),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.person, color: Colors.white),
                            SizedBox(width: 4.w),
                            const Text(
                              'Profil',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                fontFamily: "Cabin",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(105.w),
              socialLinks.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: socialLinks.map((link) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Traitez le clic sur le lien social ici
                                },
                                child: Image.network(
                                  link[
                                      'icon'], // Affiche l'icône du lien social
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 2.w),
                              Text(
                                link['name'], // Affiche le nom du réseau social
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 3.w,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Cabin",
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/insta.png',
                          color: Colors.white,
                        ),
                        Gap(8.w),
                        Image.asset(
                          'assets/icons/fb.png',
                          color: Colors.white,
                        ),
                        Gap(8.w),
                        Image.asset(
                          'assets/icons/tt.png',
                          color: Colors.white,
                        ),
                        Gap(8.w),
                        Image.asset(
                          'assets/icons/lg.png',
                          color: Colors.white,
                        ),
                      ],
                    ),
              Gap(15.w),
              Center(
                child: Text(
                  'À Propos Du Développeur',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 4.w,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Cabin",
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
