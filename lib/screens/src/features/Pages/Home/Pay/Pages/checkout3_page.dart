import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../../Favoris/Widgets/add3.dart';
import '../Widgets/TotalWidget.dart';
import '../Widgets/buildStep.dart';
import '../Widgets/widgets.dart';

class Pay3Page extends StatefulWidget {
  const Pay3Page({Key? key, required orderDetails}) : super(key: key);

  @override
  _Pay3PageState createState() => _Pay3PageState();
}

class _Pay3PageState extends State<Pay3Page> {
  late Future<Order> order;

  @override
  void initState() {
    super.initState();
    order = fetchOrder();
  }

  Future<Order> fetchOrder() async {
    print("Fetching order from API...");

    final response = await http.get(Uri.parse(
        'https://bolide.armasoft.ci/bolide_services/index.php/api/orders/20'));

    if (response.statusCode == 200) {
      print("Order data fetched successfully.");

      final data = jsonDecode(response.body);
      print("Raw data: $data");

      // Extract and print the specific order details
      final orderData = data['commandes'][0];
      print("Order Details: $orderData");

      return Order.fromJson(orderData);
    } else {
      print("Failed to load order. Status code: ${response.statusCode}");
      throw Exception('Failed to load order');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
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
              SizedBox(height: 1.h),
              FutureBuilder<Order>(
                future: order,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    print("Loading order data...");
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print("Error loading order data: ${snapshot.error}");
                    return Center(child: Text('Erreur : ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    print("Order data loaded: ${snapshot.data}");
                    return Column(
                      children: [
                        for (var piece in snapshot.data!.pieces)
                          buildOrderSummaryWidget(piece),
                        SizedBox(height: 1.h),
                        buildTotalWidget(snapshot.data!),
                      ],
                    );
                  } else {
                    print("No data available.");
                    return Center(child: Text('Aucune donnée disponible'));
                  }
                },
              ),
              SizedBox(height: 2.h),
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
      ),
    );
  }

  Widget buildOrderSummaryWidget(Piece piece) {
    print("Building order summary for piece: ${piece.libelle}");

    return Container(
      padding: EdgeInsets.all(0.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.w), color: Colors.white),
      child: Row(
        children: [
          Image.network(piece.img, width: 20.w, height: 20.w),
          SizedBox(width: 2.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  piece.libelle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  piece.description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Cabin',
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      " ${piece.price} FCFA",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Cabin',
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Add3Page(
                        initialQuantity:
                            piece.quantity), // Pass the quantity hereµ
                  ],
                )
              ],
            ),
          ),
        ],
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
