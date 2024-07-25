import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:le_bolide/screens/src/features/Pages/Home/Pay/Widgets/add.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/widgets/bouton_ajouter.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/widgets/detail_produit.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';

import '../../../../../../../data/models/api_services.dart';
import '../../pages/home_page.dart';
import '../Widgets/horizon_container.dart';
import '../Widgets/promo_code_widget.dart';
import 'checkout1_page.dart';

class PayPage extends StatefulWidget {
  final String partId;

  const PayPage({
    Key? key,
    required this.partId,
  }) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {

  int _quantity = 1;
  List<dynamic> _cartItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }

  Future<void> _fetchCartItems() async {
    const url =
        '${baseUrl}api/cart/user/2'; // Utiliser l'ID utilisateur réel si nécessaire

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _cartItems = data; // Stocker les articles du panier
          _isLoading = false;
        });
      } else {
        print('Erreur lors de la récupération des articles du panier');
      }
    } catch (e) {
      print('Erreur: $e');
    }
  }

  void _incrementQuantity() {
    setState(() {
      if (_quantity < 2) {
        _quantity++;
      }
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      } 
    });
  }



  void _navigateToPay1Page() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const Details1ProduitsPage(
          partId: '',
        ),
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
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  SizedBox(height: 2.h),
                  Padding(
                    padding: EdgeInsets.all(0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${_cartItems.length} Produits',
                            style: TextStyle(fontSize: 12.sp)),
                        Text('Sous-total ${_calculateTotal()} F',
                            style: TextStyle(fontSize: 12.sp)),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  const PromoCodeWidget(),
                  SizedBox(height: 2.h),
                  ..._cartItems.map((item) => CartItemWidget(
                        img: item['img'],
                        libelle: item['libelle'],
                        prix: double.parse(item['prix']),
                        quantite: item['quantite'],
                          partId: widget.partId, /// Assurez-vous que partId est passé
                      )),
                  SizedBox(height: 2.h),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
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
                        Center(
                          child: SizedBox(
                            width: 88.w,
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
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                     const Pay1Page(partId: '',),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
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
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 10.w),
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

  String _calculateTotal() {
    double total = 0;
    for (var item in _cartItems) {
      total += double.parse(item['prix']) * int.parse(item['quantite']);
    }
    return total.toString();
  }
}

class CartItemWidget extends StatelessWidget {
  final String img;
  final String libelle;
  final double prix;
  final String quantite;
  final String partId;

  const CartItemWidget({
    Key? key,
    required this.img,
    required this.libelle,
    required this.prix,
    required this.quantite,
    required this.partId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.w),
        color: Colors.white,
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 20.w,
          height: 25.w,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(img),
              fit: BoxFit.contain,
            ),
            borderRadius: BorderRadius.circular(0.5.h),
          ),
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
                    libelle,
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
                  'Pneu été', // Adaptez en fonction des données de l'API
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$prix F',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'Cabin',
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                AddPage(
                  partId: partId,
                  userId: 2, // Remplacez avec l'ID utilisateur réel
                  quantity: int.parse(quantite), // Pass the quantity here
                ),
              ],
            ),
          ],
        )),
      ]),
    );
  }
}
