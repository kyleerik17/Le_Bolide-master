import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:Bolide/data/services/user.dart';
import 'package:Bolide/screens/src/features/Pages/commande/pages/commande_page.dart';
import 'package:sizer/sizer.dart';

import '../../Home/Pay/Widgets/buildStep.dart';

class DetailsCommandePage extends StatefulWidget {
  final int userId;
  final int partId;
  final String? price;

  const DetailsCommandePage({
    Key? key,
    required this.userId,
    required this.partId,
    required this.price,
  }) : super(key: key);

  @override
  State<DetailsCommandePage> createState() => _DetailsCommandePageState();
}

class _DetailsCommandePageState extends State<DetailsCommandePage> {
  late User user;
  List<Item> items = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    print('Initializing DetailsCommandePage...');
    try {
      user = GetIt.instance.get<User>();
      print('User fetched successfully: ${user.name}');
    } catch (e) {
      print('Error fetching user: $e');
    }
    print('Fetching order details...');
    fetchOrderDetails(widget.partId);
  }

  Future<void> fetchOrderDetails(int partId) async {
    print('Fetching order details for partId: $partId');

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await http.get(Uri.parse(
          'https://bolide.armasoft.ci/bolide_services/index.php/api/orders/$partId'));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        print('Response JSON: $jsonResponse');

        if (jsonResponse != null) {
          var itemsList = jsonResponse['items'] as List;
          print('Items List: $itemsList');

          if (itemsList.isNotEmpty) {
            setState(() {
              items =
                  itemsList.map((itemJson) => Item.fromJson(itemJson)).toList();
              isLoading = false;
              print('Items fetched successfully: $items');
            });
          } else {
            throw Exception('La réponse ne contient pas de produits');
          }
        } else {
          throw Exception('La réponse est vide ou mal formée');
        }
      } else {
        throw Exception(
            'Échec du chargement des détails de la commande : ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Échec du chargement des détails de la commande : $e';
        print('Error fetching order details: $e');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CommandePage(
                      partId: widget.partId, userId: widget.userId)),
            );
            (context, animation, secondaryAnimation, child) {
              const begin = Offset(-1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            };
          },
          child: Container(
            padding: EdgeInsets.all(0.w),
            child: Image.asset(
              'assets/icons/gc.png',
              width: 12.w,
              height: 12.w,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Détails commande',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : SingleChildScrollView(
                  child: Container(
                    color: const Color(0xFFF7F8F9),
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Statut de la commande',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        ),
                        SizedBox(height: 2.h),
                        buildOrderStatusRow(),
                        SizedBox(height: 2.h),
                        buildOrderStepsRow(),
                        SizedBox(height: 2.h),
                        const Text(
                          'Reception prévue pour le Mardi 25 Juin à 16:00',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Cabin',
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Récapitulatif',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins"),
                        ),
                        SizedBox(height: 1.h),
                        Column(
                          children:
                              items.map((item) => buildItemCard(item)).toList(),
                        ),
                        SizedBox(height: 2.h),
                        buildOrderSummary(),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget buildOrderStatusRow() {
    return Row(
      children: [
        SizedBox(width: 2.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.2.w),
          child: Image.asset('assets/icons/cs.png'),
        ),
        SizedBox(
          width: 33.w,
          child: const Divider(color: Color(0xFF1A1A1A), thickness: 2),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.2.w),
          child: Image.asset('assets/icons/cs1.png'),
        ),
        SizedBox(
          width: 33.w,
          child: const Divider(color: Color(0xFFE0E3E6), thickness: 2),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.2.w),
          child: Image.asset('assets/icons/cs2.png'),
        ),
      ],
    );
  }

  Widget buildOrderStepsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildStep(' Préparation'),
        buildStep('Envoie'),
        buildStep('Effectuée'),
      ],
    );
  }

  Widget buildItemCard(Item item) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.5.h),
      padding: EdgeInsets.all(1.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.w),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/pn2.png',
            width: 25.w,
            height: 25.w,
          ),
          // Image.network(item.img, width: 25.w, height: 25.w),
          SizedBox(width: 2.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.libelle,
                    style: const TextStyle(
                        fontSize: 17,
                        fontFamily: 'Cabin',
                        fontWeight: FontWeight.w500)),
                SizedBox(height: 0.5.h),
                Row(
                  children: [
                    Image.asset('assets/icons/sun.png',
                        color: Colors.black, width: 5.w),
                    SizedBox(width: 1.w),
                    Text(
                      item.description,
                      style: TextStyle(
                        fontFamily: "Cabin",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Text(
                  item.price,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: 'Cabin',
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: 1.h),
              Image.asset('assets/icons/trash.png'),
              SizedBox(height: 5.h),
              Container(
                width: 12.w,
                height: 6.w,
                padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 0.3.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(1.5.w),
                ),
                child: Center(
                  child: Text(
                    item.quantity.toString(),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildOrderSummary() {
    final subtotal = _calculateSubtotal();
    final total =
        subtotal - 10000; // Ex: Si vous avez une réduction fixe de 10,000 F

    return Container(
      height: 40.w,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 5.w),
          buildSummaryRow('Sous-total', '${subtotal.toStringAsFixed(1)} F'),
          SizedBox(height: 1.h),
          buildSummaryRow('Frais de livraison', 'Gratuit'),
          SizedBox(height: 1.h),
          buildSummaryRow('Code promo', 'BOL10 (-10%)'),
          Center(
            child: SizedBox(
              width: 88.w,
              child: Divider(height: 2.h, color: Colors.grey),
            ),
          ),
          SizedBox(height: 1.h),
          buildSummaryRow('TOTAL', '${subtotal.toStringAsFixed(1)} F',
              isTotal: true),
        ],
      ),
    );
  }

  double _calculateSubtotal() {
    return items.fold(
        0.0, (sum, item) => sum + double.parse(item.price) * item.quantity);
  }

  Widget buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 14.sp : 12.sp,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
              fontFamily: isTotal ? 'Poppins' : 'Poppins',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 4.w),
          child: Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 14.sp : 12.sp,
              fontWeight: FontWeight.w600,
              fontFamily: isTotal ? 'Poppins' : 'Cabin',
            ),
          ),
        ),
      ],
    );
  }
}

class Item {
  final String img;
  final String libelle;
  final String description;
  final String price;
  final int quantity;

  Item({
    required this.img,
    required this.libelle,
    required this.description,
    required this.price,
    required this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    print('Creating Item from JSON: $json');
    return Item(
      img: json['img'],
      libelle: json['libelle'],
      description: json['description'],
      price: json['price'],
      quantity: int.parse(json['quantity']),
    );
  }
}
