import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:le_bolide/screens/src/features/Pages/Home/Pay/Widgets/TotalWidget.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/Pay/Widgets/add.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/widgets/detail_produit.dart';
import 'package:le_bolide/screens/src/features/Pages/profile/pages/pages.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';

import '../../../../../../../data/models/api_services.dart';
import '../../pages/home_page.dart';
import '../Widgets/horizon_container.dart';
import '../Widgets/promo_code_widget.dart';
import 'checkout1_page.dart';

class PayPage extends StatefulWidget {
  final int partId;
  final int userId;
  final List cartItems;

  const PayPage({
    Key? key,
    required this.partId,
    required this.userId,
    required this.cartItems,
  }) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  int _quantity = 1;
  List<dynamic> _cartItems = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }

  Future<void> _fetchCartItems() async {
    final url = '${baseUrl}api/cart/user/${widget.userId}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _cartItems = data;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage =
              'Erreur lors de la récupération des articles du panier';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Erreur: $e';
      });
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
        pageBuilder: (context, animation, secondaryAnimation) => Pay1Page(
          partId: widget.partId,
          userId: widget.userId,
          cartItems: _cartItems,
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
                    HomePage(
                  userId: widget.userId,
                  partId: widget.partId,
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
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(children: [
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _errorMessage.isNotEmpty
                        ? Center(child: Text(_errorMessage))
                        : Column(
                            children: [
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.all(2.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${_cartItems.length} Produits',
                                        style: TextStyle(fontSize: 12.sp)),
                                    Text('Sous-total ${_calculateTotal()} F',
                                        style: TextStyle(fontSize: 12.sp)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 1.h),
                              const PromoCodeWidget(),
                              SizedBox(height: 1.h),
                              ..._cartItems.map((item) => CartItemWidget(
                                    img: item['img'],
                                    libelle: item['libelle'],
                                    prix: double.tryParse(
                                            item['prix'].toString()) ??
                                        0.0,
                                    quantite: int.tryParse(
                                            item['quantite'].toString()) ??
                                        0,
                                    partId: widget.partId,
                                    userId: widget.userId,
                                    onRemove: (int partId) {},
                                  )),
                              SizedBox(height: 1.h),
                              Padding(
                                padding: EdgeInsets.all(0.w),
                                child: const Text(
                                  '* Vous serez notifié quand le produit sera en stock',
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Souvent acheté ensemble...',
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 3),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFC9CDD2)),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                              SizedBox(height: 1.h),
                              SizedBox(height: 5.w),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  backgroundColor: const Color(0xFF1A1A1A),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1.5.h, horizontal: 10.h),
                                ),
                                onPressed: _navigateToPay1Page,
                                child: Text(
                                  'Passer la commande',
                                  style: TextStyle(
                                    fontFamily: "Cabin",
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
              ]),
            ))
          ],
        ),
      ),
    );
  }

  double _calculateTotal() {
    return _cartItems.fold(0.0, (sum, item) {
      double prix = double.tryParse(item['prix'].toString()) ?? 0.0;
      int quantite = int.tryParse(item['quantite'].toString()) ?? 0;
      return sum + (prix * quantite);
    });
  }
}

class CartItemWidget extends StatelessWidget {
  final String img;
  final String libelle;
  final double prix;
  final int quantite;
  final int partId;
  final int userId;
  final Function(int partId) onRemove; // Callback for removal

  const CartItemWidget({
    Key? key,
    required this.img,
    required this.libelle,
    required this.prix,
    required this.quantite,
    required this.partId,
    required this.userId,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      margin: EdgeInsets.symmetric(vertical: 0.5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            img,
            width: 25.w,
            height: 25.w,
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      libelle,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showConfirmationDialog(context),
                      child: Image.asset(
                        'assets/icons/trash.png',
                        width: 6.w,
                        height: 6.w,
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
                      width: 5.w,
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
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Text(
                      '${prix.toString()} F',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Cabin',
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    // Assume AddPage is a widget to adjust the quantity
                    AddPage(
                      userId: userId,
                      partId: partId,
                      initialQuantity: quantite,
                      quantity: quantite,
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

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmer la suppression'),
          content: Text(
              'Êtes-vous sûr de vouloir supprimer cet article du panier ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await _removeItemFromCart();
              },
              child: Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _removeItemFromCart() async {
    final url =
        'https://bolide.armasoft.ci/bolide_services/index.php/api/cart/remove/$userId/4';

    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == 'success') {
        // Handle successful removal, e.g., show a snackbar or update the UI
        print('Item removed successfully');
        onRemove(partId); // Notify parent to remove item from UI
      } else {
        // Handle failure, e.g., show an error message
        print('Failed to remove item: ${responseBody['message']}');
      }
    } else {
      // Handle HTTP error
      print('HTTP error: ${response.statusCode}');
    }
  }
}
