import 'package:flutter/material.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/Pay/Pages/checkout1_page.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/Pay/Pages/checkout_page.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/Pay/Widgets/OrderSummary.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/Pay/Widgets/SecurePayment.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/pages/home_page.dart';
import 'package:sizer/sizer.dart';

import '../Widgets/TotalWidget.dart';
import '../Widgets/buildStep.dart';

class Pay3Page extends StatelessWidget {
  const Pay3Page({
    Key? key,
    required this.orderDetails,
    required this.partId,
    required this.cartItems,
    required this.deliveryAddress,
    required this.userId,
  }) : super(key: key);

  final dynamic orderDetails;
  final int partId;
  final List<Map<String, dynamic>> cartItems;
  final String deliveryAddress;
  final int userId;

  double _calculateTotal() {
    return cartItems.fold(0.0, (sum, item) => sum + (item['price'] ?? 0.0));
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
                    PayPage(
                  partId: partId,
                  cartItems: const [],
                  userId: userId,
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
          'Confirmation',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF7F8F9),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSecurePaymentWidget(),
              SizedBox(height: 4.w),
              Row(
                children: [
                  SizedBox(width: 2.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.2.w),
                    child: Image.asset(
                      'assets/icons/cs.png',
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
                      'assets/icons/cs.png',
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
                      'assets/icons/cs1.png',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildStep('  Livraison'),
                  buildStep('Paiement'),
                  buildStep('Confirmation'),
                ],
              ),
              SizedBox(height: 4.h),
              const Text(
                "Commande validée",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Merci, votre commande a été validée avec succès. Vous recevrez des notifications pour suivre l'évolution de votre commande, ou consultez l'onglet “Commandes”",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xff1A1A1A),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Cabin",
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/rec.png',
                          width: 8.w,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          'Commande XDR 980 992',
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(width: 35.w),
                        Image.asset(
                          'assets/icons/fw.png',
                          color: Colors.black,
                          width: 2.5.w,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              const Text(
                "Récapitulatif",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: 2.h),
              buildOrderSummaryWidget(cartItems),
              SizedBox(height: 1.w),
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
                          child: Text(
                            'Sous-total',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Text(
                            '${_calculateTotal()} F',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Cabin',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: Text(
                            'Frais de livraison',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Text(
                            'Gratuit',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Cabin',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: Text(
                            'Code promo',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Text(
                            'BOLI10',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Cabin',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 2,
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Text(
                            '${_calculateTotal()} F',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Cabin',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                userId: userId,
                                partId: partId,
                              )),
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
                        "Terminer",
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
}
