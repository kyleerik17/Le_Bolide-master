import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:Bolide/data/services/user.dart';
import 'package:Bolide/screens/src/features/Pages/Favoris/Widgets/add3.dart';
import 'package:Bolide/screens/src/features/Pages/Home/Pay/Pages/checkout1_page.dart';
import 'package:Bolide/screens/src/features/Pages/Home/Pay/Pages/checkout_page.dart';
import 'package:Bolide/screens/src/features/Pages/Home/Pay/Widgets/OrderSummary.dart';
import 'package:Bolide/screens/src/features/Pages/Home/Pay/Widgets/SecurePayment.dart';
import 'package:Bolide/screens/src/features/Pages/Home/pages/home_page.dart';
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
    return cartItems.fold(0.0, (sum, item) {
      final price = double.tryParse(item['prix'].toString()) ?? 0.0;
      final quantity = int.tryParse(item['quantite'].toString()) ?? 0;
      return sum + (price * quantity);
    });
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Image.asset(
                        'assets/icons/rec.png',
                        width: 8.w,
                      ),
                    ]),
                    SizedBox(width: 1.w),
                    Row(
                      children: [
                        Text(
                          'Commande XDR 980 992',
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(width: 2.w),
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
              Container(
                padding: EdgeInsets.all(0.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.w),
                  color: Colors.white,
                ),
                child: Column(
                  children: cartItems.map((item) {
                    return CartItem2Widget(
                      img: item['img'] ?? '',
                      libelle: item['libelle'] ?? '',
                      prix: double.tryParse(item['prix'].toString()) ?? 0.0,
                      quantite: int.tryParse(item['quantite'].toString()) ?? 0,
                      partId: int.tryParse(item['id_produit'].toString()) ?? 0,
                      userId: userId,
                      total_price:
                          (double.tryParse(item['prix'].toString()) ?? 0.0) *
                              (int.tryParse(item['quantite'].toString()) ?? 0),
                      onRemove: (userId, partId) {
                        print(
                            'Remove item with userId: $userId, partId: $partId');
                        print('Cart items: $cartItems');

                        // Define the removal logic here
                        print('Cart items: $cartItems');
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 1.w),
              Container(
                height: 35.w,
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
                            '${_calculateTotal().toStringAsFixed(0)} F',
                            style: TextStyle(
                              fontSize: 14.sp,
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
                    // SizedBox(height: 1.h),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.only(left: 4.w),
                    //       child: Text(
                    //         'Code promo',
                    //         style: TextStyle(
                    //           fontSize: 12.sp,
                    //           fontWeight: FontWeight.w400,
                    //           fontFamily: 'Poppins',
                    //         ),
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.only(right: 4.w),
                    //       child: Text(
                    //         'BOLI10',
                    //         style: TextStyle(
                    //           fontSize: 12.sp,
                    //           fontWeight: FontWeight.w600,
                    //           fontFamily: 'Cabin',
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Center(
                      child: SizedBox(
                        width: 85.w,
                        child: Divider(
                          height: 2.h,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: Text(
                            'TOTAL',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Text(
                            '${_calculateTotal().toStringAsFixed(0)} F',
                            style: TextStyle(
                              fontSize: 14.sp,
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
              SizedBox(height: 3.h),
              Center(
  child: TextButton(
    onPressed: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) => HomePage(
            userId: userId,
            partId: partId,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const offsetBegin = Offset(1.0, 0.0); // Commence de la droite
            const offsetEnd = Offset.zero; // Finit à la position actuelle
            const curve = Curves.easeInOutCubic; // Courbe plus fluide

            var tween = Tween(begin: offsetBegin, end: offsetEnd)
                .chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
        ),
      );
    },
    style: TextButton.styleFrom(
      backgroundColor: const Color(0xFF1A1A1A),
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 20.w),
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
)

            ],
          ),
        ),
      ),
    );
  }
}

class CartItem2Widget extends StatefulWidget {
  final String img;
  final String libelle;
  final double prix;
  final int quantite;
  final double total_price;
  final int partId;
  final int userId;
  final Function(int userId, int partId) onRemove;

  CartItem2Widget({
    Key? key,
    required this.img,
    required this.libelle,
    required this.prix,
    required this.quantite,
    required this.partId,
    required this.userId,
    required this.onRemove,
    required this.total_price,
  }) : super(key: key);

  @override
  State<CartItem2Widget> createState() => _CartItem2WidgetState();
}

class _CartItem2WidgetState extends State<CartItem2Widget> {
  int userIdConnect = 0;
  late User user;

  @override
  void initState() {
    try {
      user = GetIt.instance.get<User>();
      userIdConnect = user.id;
      print(user.name);
      print('user info');
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.w,
      margin: EdgeInsets.symmetric(vertical: 0.5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.network(
            widget.img,
            height: 25.w,
            width: 25.w,
          ),
          Expanded(
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      widget.libelle,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/ea.png',
                      color: const Color(0xFF1A1A1A),
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      'Pneu été',
                      style: TextStyle(
                        fontFamily: "Cabin",
                        color: const Color(0xFF1A1A1A),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${widget.prix.toString()} F',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Cabin',
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(width: 30.w),
                    Add3Page(
                      userId: widget.userId,
                      partId: widget.partId,
                      initialQuantity: widget.quantite,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
