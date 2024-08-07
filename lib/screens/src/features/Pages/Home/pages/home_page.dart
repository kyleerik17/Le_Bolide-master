import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importez ceci pour accéder à SystemChrome
import 'package:le_bolide/screens/src/features/Pages/registration/pages/registration_page.dart';
import 'package:sizer/sizer.dart';
import '../../loading modal/pages/pages.dart';
import '../widgets/appbar.dart';
import '../widgets/bottom.dart';
import '../widgets/marque.dart';
import '../widgets/categorie.dart';
import '../widgets/search.dart';
import '../widgets/slider.dart';
import 'Categories/pages/categorie_page.dart';

class HomePage extends StatefulWidget {
  final int partId;
  final int userId;

  const HomePage({
    Key? key,
    required this.partId,
    required this.userId,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    // Vérifiez si l'ID utilisateur est valide, sinon redirigez vers RegistrationPage
    if (widget.userId <= 0) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
          context,
          _createSlideTransition(
            RegistrationPage(userId: widget.userId, partId: widget.partId),
          ),
        );
      });
    }
  }

  PageRouteBuilder _createSlideTransition(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end);
        var offsetAnimation =
            animation.drive(tween.chain(CurveTween(curve: curve)));

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          AppBarWidget(partId: widget.partId, userId: widget.userId),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Nouveau chez Bolide 🔥",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                                fontFamily: "Poppins",
                              ),
                              textAlign: TextAlign.center,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  _createSlideTransition(
                                    CategoriesPage(
                                      partId: widget.partId,
                                      userId: widget.userId,
                                      categoryName: '',
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Voir tout",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.sp,
                                  fontFamily: "Cabin",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  SearchBarWidget(partId: widget.partId, userId: widget.userId),
                  SizedBox(height: 2.h),
                  const SliderPage(),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Catégories",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                                fontFamily: "Poppins",
                              ),
                              textAlign: TextAlign.center,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  _createSlideTransition(
                                    CategoriesPage(
                                      partId: widget.partId,
                                      userId: widget.userId,
                                      categoryName: '',
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Voir tout",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.sp,
                                  fontFamily: "Cabin",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Categorie(partId: widget.partId, userId: widget.userId),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Les marques populaires",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                                fontFamily: "Poppins",
                              ),
                              textAlign: TextAlign.center,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Voir tout",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.sp,
                                  fontFamily: "Cabin",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  const MarquePopu(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
          onTap: (int) {}, partId: widget.partId, userId: widget.userId),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(
              bottom: 5.h), // Ajustez cette valeur selon vos besoins
          width: 20.w,
          height: 20.w,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                _createSlideTransition(
                  SearchLoadPage(partId: widget.partId, userId: widget.userId),
                ),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13.w),
            ),
            backgroundColor: Colors.black,
            child: Image.asset(
              'assets/icons/home.png',
              width: 10.w,
              height: 10.h,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
