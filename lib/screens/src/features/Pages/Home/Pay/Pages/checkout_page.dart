import 'package:flutter/material.dart';
import 'package:le_bolide/screens/src/features/Pages/Favoris/Widgets/add3.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/Pay/Widgets/add2.dart';
import 'package:sizer/sizer.dart';
import '../../../commande/pages/details-produit_page.dart';
import '../../pages/pages.dart';
import '../../widgets/widgets.dart';
import '../Widgets/widgets.dart';
import 'pages.dart';

class PayPage extends StatefulWidget {
  final String partId; // Add this line

  const PayPage({
    Key? key,
    required this.partId, // Add this line
  }) : super(key: key);

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
                            QuantityWidget(partId: widget.partId, userId: '2'), // Pass partId here
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
                            SizedBox(width: 9.w),
                             QuantityWidget(partId: '2', userId: '2'), // Pass partId here as well
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
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