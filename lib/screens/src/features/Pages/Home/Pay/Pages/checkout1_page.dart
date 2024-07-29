import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Widgets/formulaire_livraison.dart';
import 'pages.dart';

class Pay1Page extends StatelessWidget {
  final int partId;
  final int userId;
  final List<dynamic> cartItems; // Liste des éléments du panier

  const Pay1Page({
    Key? key,
    required this.partId,
    required this.userId,
    required this.cartItems, // Recevoir les éléments du panier
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    Pay2Page(
                  partId: partId,
                  userId: userId,
                  cartItems:
                      cartItems, // Passer les éléments du panier à Pay2Page
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(-1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  final tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  final offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
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
        backgroundColor: Colors.white,
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
                  children: [
                    SizedBox(width: 2.w),
                    Image.asset(
                      'assets/icons/lgo.png',
                      width: 8.w,
                    ),
                    SizedBox(width: 30.w),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/lock.png',
                          width: 8.w,
                        ),
                        SizedBox(width: 4.w),
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
              SizedBox(height: 3.h),
              Row(
                children: [
                  SizedBox(width: 2.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.2.w),
                    child: Image.asset(
                      'assets/icons/cs1.png',
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
                    child: Image.asset(
                      'assets/icons/cs2.png',
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
                    child: Image.asset(
                      'assets/icons/cs2.png',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStep('  Livraison'),
                  _buildStep('Paiement'),
                  _buildStep('Confirmation'),
                ],
              ),
              SizedBox(height: 3.h),
              Text(
                "Ajoutez votre adresse de livraison",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "* Champs obligatoires",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Cabin",
                ),
              ),
              FormulaireLivraison(
                userId: userId,
                onInformationChanged: (String name, String surname,
                    String email, String country, String address) {},
              ),
              SizedBox(height: 1.h),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Pay2Page(
                          partId: partId,
                          userId: userId,
                          cartItems:
                              cartItems, // Passer les éléments du panier à Pay2Page
                        ),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          final tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          final offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 20.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.w),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
}
