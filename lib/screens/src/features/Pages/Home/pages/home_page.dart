import 'package:Bolide/screens/src/features/Pages/Home/pages/Categories/pages/categorie_page.dart';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/bottom.dart';
import 'package:Bolide/screens/src/features/Pages/commande/widgets/slider1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:get_it/get_it.dart';

import 'package:Bolide/screens/src/features/Pages/Search/Pages/find_search_page.dart';
import 'package:Bolide/screens/src/features/Pages/commande/widgets/bottom.dart';
import 'package:Bolide/screens/src/features/Pages/registration/pages/registration_page.dart';
import 'package:Bolide/screens/src/features/Pages/loading modal/pages/pages.dart';
import 'package:Bolide/screens/src/features/Pages/Home/Pay/Widgets/horizon_container.dart';
import 'package:Bolide/screens/src/features/Pages/commande/widgets/botom.dart';
import 'package:Bolide/screens/src/features/Pages/commande/widgets/bottom.dart';

import 'package:Bolide/screens/src/features/Pages/Home/widgets/appbar.dart';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/categorie.dart';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/marque.dart';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/slider.dart';
import 'package:Bolide/data/services/user.dart';

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
  late User user;
  late String categoryName = ''; // Valeur par défaut
  List<String> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
    _loadUser();
    // Configure la barre d'état pour Android
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF1A1A1A),
      statusBarIconBrightness: Brightness.light,
    ));
  }

  Future<void> _loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    cartItems = prefs.getStringList('cartItems') ?? [];
    setState(() {});
  }

  Future<void> _loadUser() async {
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
  }

  Future<void> _addToCart(String item) async {
    cartItems.add(item);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cartItems', cartItems);
    setState(() {});
  }

  bool isCartEmpty() {
    return cartItems.isEmpty;
  }

  // Transition pour glisser depuis le bas
  PageRouteBuilder _createSlideTransition(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end);
        var offsetAnimation =
            animation.drive(tween.chain(CurveTween(curve: curve)));

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  // Transition pour glisser depuis la droite
  PageRouteBuilder _createSlide1Transition(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
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
          AppBarWidget(
            partId: widget.partId,
            userId: widget.userId,
          ),
          SizedBox(height: 2.h),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchField(),
                  SizedBox(height: 1.h),
                  _buildSectionHeader(
                    title: "Nouveau chez Bolide 🔥",
                    onViewAllTap: () {
                      Navigator.push(
                        context,
                        _createSlide1Transition(
                          CategoriesPage(
                            partId: widget.partId,
                            userId: widget.userId,
                            categoryName: categoryName,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 1.h),
                  const SliderPage(),
                  SizedBox(height: 2.h),
                  _buildSectionHeader(
                    title: "Catégories",
                    onViewAllTap: () {
                      Navigator.push(
                        context,
                        _createSlide1Transition(
                          CategoriesPage(
                            partId: widget.partId,
                            userId: widget.userId,
                            categoryName: categoryName,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 1.h),
                  Categorie(partId: widget.partId, userId: widget.userId),
                  SizedBox(height: 2.h),
                  ContaiRizon(
                    userId: user.id,
                    partId: widget.partId,
                  ),
                  _buildSectionHeader(
                    title: "Les marques populaires",
                    onViewAllTap: () {},
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
        partId: widget.partId,
        userId: widget.userId,
        onTap: (int) {},
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildSearchField() {
    return Container(
      width: 92.w,
      height: 40,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFCED0D4)),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
        ),
      ),
      child: TextField(
        onTap: () {
          Navigator.push(
            context,
            _createSlideTransition(
              FindSearchPage(partId: widget.partId, userId: widget.userId),
            ),
          );
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          hintText: 'Rechercher...',
          hintStyle: TextStyle(
            color: Color(0xFF737373),
            fontFamily: 'Cabin',
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 0),
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              width: 16,
              height: 16,
              color: Colors.black,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 8),
        ),
        style: const TextStyle(
          color: Color(0xFF737373),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required VoidCallback onViewAllTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                  fontFamily: "Poppins",
                ),
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                onTap: onViewAllTap,
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
    );
  }

  Widget _buildFloatingActionButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 5.h),
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
    );
  }
}
