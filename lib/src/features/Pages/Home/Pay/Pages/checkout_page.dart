import 'package:flutter/material.dart';
import 'package:le_bolide/src/features/Pages/Home/Pay/Pages/checkout1_page.dart';
import 'package:le_bolide/src/features/Pages/Home/Pay/Widgets/add.dart';
import 'package:le_bolide/src/features/Pages/Home/Pay/Widgets/horizon_container.dart';
import 'package:le_bolide/src/features/Pages/Home/pages/home_page.dart';
import 'package:le_bolide/src/features/Pages/Home/widgets/bouton_ajouter.dart';
import 'package:sizer/sizer.dart';

import '../../../commande/pages/details-produit_page.dart';

class PayPage extends StatefulWidget {
  const PayPage({Key? key}) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  bool _showQuantityControls = false;
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      if (_quantity < 2) {
        _quantity++;
      } else {
        _navigateToPay1Page();
      }
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      } else {
        _showQuantityControls = false;
        _quantity = 1;
      }
    });
  }

  void _toggleQuantityControls() {
    setState(() {
      _showQuantityControls = !_showQuantityControls;
    });
  }

  void _navigateToPay1Page() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const DetailsProduitsPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

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
                    const HomePage(),
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
          'Panier',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFF7F8F9),
        padding: EdgeInsets.all(2.w),
        margin: EdgeInsets.all(2.w),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('02 Produits', style: TextStyle(fontSize: 12.sp)),
                  Text('Sous-total 76 000 F',
                      style: TextStyle(fontSize: 12.sp)),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            const PromoCodeWidget(),
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.w),
                color: Colors.white,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/pn.png',
                        width: 25.w,
                        height: 25.w,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Radar Rivera PRO 2 165/65\n R13 77T',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: 'Cabin',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Column(children: [
                              Image.asset(
                                'assets/icons/trash.png',
                              ),
                            ]),
                          ],
                        ),
                        SizedBox(height: 0.5.h),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/sun.png',
                              color: const Color(0xFF1A1A1A),
                              width: 4.w,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              'Pneu été',
                              style: TextStyle(
                                fontFamily: "Cabin",
                                color: const Color(0xFF1A1A1A),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '38 000 F',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'Cabin',
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),
                            SizedBox(width: 9.w),
                            const QuantityWidget()
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.h),
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.w),
                color: Colors.white,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/fr.jpeg',
                        width: 25.w,
                        height: 25.w,
                        fit: BoxFit.contain,
                      ),
                      Positioned(
                        bottom: 25,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFEB4143),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.w),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w, vertical: 0.5.h),
                            minimumSize: const Size(1, 1),
                          ),
                          child: const Text(
                            'Hors Stock',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontFamily: 'Inter Medium',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'RIDEX 3405B1557 Disques\net plaquettes de freins',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: 'Cabin',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Column(children: [
                              Image.asset(
                                'assets/icons/trash.png',
                              ),
                            ]),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/ea.png',
                              color: const Color(0xFF1A1A1A),
                              width: 4.w,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              'Essieu arrière',
                              style: TextStyle(
                                fontFamily: "Cabin",
                                color: const Color(0xFF1A1A1A),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '69 000 F',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'Cabin',
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFEB4143),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 0.5.h),
                                minimumSize: const Size(1, 1),
                              ),
                              child: Text(
                                'Hors Stock',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                    fontFamily: 'Inter Medium',
                                    fontWeight: FontWeight.w500),
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
            SizedBox(height: 1.h),
            Padding(
              padding: EdgeInsets.all(2.w),
              child: const Text(
                '* Vous serez notifier quand le produit sera en stock',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1A1A1A),
                  fontFamily: "Cabin",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Souvent acheter ensemble...',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Voir tout',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: "Cabin",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const ContaiRizon(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFC9CDD2)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/pct.png',
                    width: 6.w,
                    height: 6.w,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Entrez un code promo',
                        hintStyle: TextStyle(
                            fontFamily: 'Cabin',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xFF94979E)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Appliquer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              height: 40.w,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 5.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Text('Sous-total',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: Text('76 000 F',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Cabin')),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Text('Frais de livraison',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: Text('Gratuit',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Cabin')),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Text('Code promo',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: Text('BOL10 (-10%)',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Cabin')),
                      ),
                    ],
                  ),
                  Container(
                    child: Center(
                      child: SizedBox(
                        width: 88.w,
                        child: Divider(
                          height: 2.h,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Text('TOTAL',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: Text('68 400 F',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const Pay1Page(),
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
                      EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.w),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Passer la commande",
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
    );
  }
}

class PromoCodeWidget extends StatelessWidget {
  const PromoCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2.w),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/pct.png',
              width: 4.w,
              height: 4.w,
            ),
            SizedBox(width: 1.w),
            Text(
              '-10% DE REDUCTION AVEC LE CODE "BOL10"',
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Cabin',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ));
  }
}
