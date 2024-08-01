import 'package:flutter/material.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/Pay/Widgets/OrderSummary.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/Pay/Widgets/SecurePayment.dart';

import 'package:sizer/sizer.dart';

import '../Widgets/TotalWidget.dart';
import '../Widgets/buildStep.dart';

class Pay3Page extends StatefulWidget {
  const Pay3Page(
      {Key? key,
      required orderDetails,
      required int partId,
      required List cartItems,
      required int userid,
      required int userId})
      : super(key: key);

  @override
  State<Pay3Page> createState() => _Pay3PageState();
}

class _Pay3PageState extends State<Pay3Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 3.h),
            buildSecurePaymentWidget(),
            SizedBox(height: 3.h),
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
            SizedBox(height: 3.h),
            Text(
              "Commande validée",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              "Merci, votre commande a été validée avec succès. Vous recevrez des notifications pour suivre l'évolution de votre commande, ou consultez l'onglet “Commandes”",
              style: TextStyle(
                fontSize: 10.sp,
                color: const Color(0xff1A1A1A),
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
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
                      SizedBox(width: 30.w),
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
            Text(
              "Récapitulatif",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
              ),
            ),
            SizedBox(height: 2.h),
           Container(
    padding: EdgeInsets.all(2.w),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.w), color: Colors.white),
    child: Row(
      children: [
        Image.asset('assets/images/pn2.png', width: 20.w, height: 20.w),
        SizedBox(width: 2.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Radar Rivera PRO 2 165/65 R13 77T',
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'Cabin',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/sun.png',
                    color: const Color(0xFF1A1A1A),
                    width: 5.w,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    'Pneu été',
                    style: TextStyle(
                      fontFamily: "Cabin",
                      fontSize: 12.sp,
                      color: const Color(0xFF1A1A1A),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.5.h),
              Text(
                '38 000 F',
                style:
                    TextStyle(fontSize: 12.sp, color: const Color(0xFF1A1A1A)),
              ),
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(height: 8.h),
            Container(
              width: 12.w,
              height: 6.w,
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 0.1.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(1.2.w),
              ),
              child: Text(
                '2',
                style: TextStyle(fontSize: 12.sp),
              ),
            )
          ],
        ),
      ],
    ),
  ),
            SizedBox(height: 5.w),
            // buildTotalWidget(),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const FindSearchPlusPage()),
                  // );
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
    );
  }
}

class Order {
  final int id;
  final int userId;
  final double totalPrice;
  final String status;
  final String deliveryAddress;
  final int paymentMethodId;
  final String createdAt;
  final String updatedAt;
  final List<Piece> pieces;

  Order({
    required this.id,
    required this.userId,
    required this.totalPrice,
    required this.status,
    required this.deliveryAddress,
    required this.paymentMethodId,
    required this.createdAt,
    required this.updatedAt,
    required this.pieces,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    print("Parsing Order from JSON: $json");

    return Order(
      id: int.parse(json['id']),
      userId: int.parse(json['user_id']),
      totalPrice: double.parse(json['total_price']),
      status: json['status'],
      deliveryAddress: json['delivery_address'],
      paymentMethodId: int.parse(json['payment_method_id']),
      createdAt: json['created_at'],
      updatedAt: json['update_at'],
      pieces: List<Piece>.from(json['Pieces'].map((x) => Piece.fromJson(x))),
    );
  }
}

class Piece {
  final int id;
  final int orderId;
  final int partId;
  final int quantity;
  final double price;
  final String img;
  final String libelle;
  final String description;

  Piece({
    required this.id,
    required this.orderId,
    required this.partId,
    required this.quantity,
    required this.price,
    required this.img,
    required this.libelle,
    required this.description,
  });

  factory Piece.fromJson(Map<String, dynamic> json) {
    print("Parsing Piece from JSON: $json");

    return Piece(
      id: int.parse(json['id']),
      orderId: int.parse(json['order_id']),
      partId: int.parse(json['part_id']),
      quantity: int.parse(json['quantity']),
      price: double.parse(json['price']),
      img: json['img'],
      libelle: json['libelle'],
      description: json['description'],
    );
  }
}
