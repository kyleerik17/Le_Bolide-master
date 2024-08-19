import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:Bolide/data/services/user.dart';
import 'package:Bolide/screens/src/features/Pages/Home/Pay/Pages/checkout2_page.dart';
import 'package:Bolide/screens/src/features/Pages/Home/Pay/Widgets/TotalWidget.dart';
import 'package:Bolide/screens/src/features/Pages/Home/Pay/Widgets/add.dart';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/detail_produit.dart';
import 'package:Bolide/screens/src/features/Pages/profile/pages/pages.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import '../../../../../../../data/models/api_services.dart';
import '../../pages/home_page.dart';
import '../Widgets/horizon_container.dart';
import '../Widgets/promo_code_widget.dart';
import 'checkout1_page.dart';

class PayPage extends StatefulWidget {
  late int partId;
  final int userId;
  final List<Map<String, dynamic>> cartItems;

  PayPage({
    Key? key,
    required this.partId,
    required this.userId,
    required this.cartItems,
  }) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  int _quantity = 0;
  List<Map<String, dynamic>> _cartItems = []; // Corrected type
  bool _isLoading = true;
  String _errorMessage = '';
  late User user;

  @override
  void initState() {
    try {
      user = GetIt.instance.get<User>();
      print(user.name);
      print('user info');
    } catch (e) {
      print(e);
    }
    super.initState();
    _fetchCartItems();
  }

  Future<void> _fetchCartItems() async {
    final url = '${baseUrl}api/cart/user/${user.id}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        setState(() {
          _cartItems =
              data.map((item) => item as Map<String, dynamic>).toList();
          print('Cart Items: $_cartItems'); // Imprimer les éléments du panier
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

  void _removeItemAndRefresh(int userId, int partId) async {
    final removed = await _removeItemFromCart(user.id, partId);
    if (removed) {
      await _fetchCartItems(); // Recharge les articles du panier
      print(
          'Cart Items after removal: $_cartItems'); // Imprimer les éléments après suppression
      setState(() {}); // Force le widget à se reconstruire
    }
  }

  Future<bool> _removeItemFromCart(int userId, int partId) async {
    final url = '${baseUrl}api/cart/remove/${user.id}/$partId';

    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody['status'] == 'success') {
          print('Item removed successfully');
          return true;
        } else {
          print('Failed to remove item: ${responseBody['message']}');
          return false;
        }
      } else {
        print('HTTP error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error removing item: $e');
      return false;
    }
  }

  void _navigateToPay1Page() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Pay1Page(
          partId: widget.partId,
          userId: widget.userId,
          cartItems: _cartItems, deliveryAddress: '',
          // Vous pouvez également passer d'autres paramètres nécessaires
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const offsetBegin = Offset(1.0, 0.0); // Commence de la gauche
          const offsetEnd = Offset.zero; // Finit à la position actuelle
          const curve = Curves.easeInOutCubic; // Courbe plus fluide

          var tween = Tween(begin: offsetBegin, end: offsetEnd)
              .chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    ).then((_) {
      // Après la navigation vers Pay1Page, envoyez les articles à Pay2Page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Pay2Page(
            cartItems: _cartItems,
            partId: widget.partId,
            userId: user.id,
            orderDetails: const [],
            deliveryAddress: '',
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
        'Building PayPage with Cart Items: $_cartItems'); // Imprimer les éléments pendant la construction

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
                child: Column(
                  children: [
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _errorMessage.isNotEmpty
                            ? Center(child: Text(_errorMessage))
                            : Column(
                                children: [
                                  SizedBox(height: 1.h),
                                  Padding(
                                    padding: EdgeInsets.all(4.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${_cartItems.length} Produits',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontFamily: 'Cabin',
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF1A1A1A),
                                          ),
                                        ),
                                        Text(
                                          'Sous-total ${_calculateTotal()} F',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Cabin',
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF1A1A1A),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 1.h),
                                  if (_cartItems.isNotEmpty)
                                    ..._cartItems.map((item) => CartItemWidget(
                                          img: item['img'],
                                          libelle: item['libelle'],
                                          prix: double.tryParse(
                                                  item['prix'].toString()) ??
                                              0.0,
                                          quantite: int.tryParse(
                                                  item['quantite']
                                                      .toString()) ??
                                              0,
                                          partId: int.parse(item['id_produit']),
                                          userId: widget.userId,
                                          onRemove: _removeItemAndRefresh,
                                        )),
                                  SizedBox(height: 80.w),
                                  Container(
                                    height: 34.w,
                                    width: double.infinity,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 5.w),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.w),
                                              child: Text(
                                                'Sous-total',
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4.w),
                                              child: Text(
                                                '${_calculateTotal()} F',
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Cabin',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 1.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.w),
                                              child: Text(
                                                'Frais de livraison',
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4.w),
                                              child: Text(
                                                'Gratuit',
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Cabin',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // SizedBox(height: 1.h),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     Padding(
                                        //       padding:
                                        //           EdgeInsets.only(left: 4.w),
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
                                        //       padding:
                                        //           EdgeInsets.only(right: 4.w),
                                        //       child: Text(
                                        //         'BOL10 (-10%)',
                                        //         style: TextStyle(
                                        //           fontSize: 12.sp,
                                        //           fontWeight: FontWeight.w600,
                                        //           fontFamily: 'Cabin',
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        // SizedBox(height: 1.h),
                                        Container(
                                          child: Center(
                                            child: SizedBox(
                                              width: 92.w,
                                              child: Divider(
                                                height: 2.h,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 1.5.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.w),
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
                                              padding:
                                                  EdgeInsets.only(right: 4.w),
                                              child: Text(
                                                '${_calculateTotal()} F',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 4.w),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(1.w)),
                                      backgroundColor: _cartItems.isNotEmpty
                                          ? const Color(0xFF1A1A1A)
                                          : Colors
                                              .grey, // Couleur lorsque désactivé
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1.5.h, horizontal: 10.h),
                                    ),
                                    onPressed: _cartItems.isNotEmpty
                                        ? _navigateToPay1Page
                                        : null, // Désactiver le bouton si le panier est vide
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
                    SizedBox(height: 3.w),
                  ],
                ),
              ),
            ),
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

class CartItemWidget extends StatefulWidget {
  final String img;
  final String libelle;
  final double prix;
  final int quantite;
  final int partId;
  final int userId;
  final Function(int userId, int partId) onRemove;

  CartItemWidget({
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
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
      child: Container(
        height: 34.w,
        margin: EdgeInsets.symmetric(vertical: 0.5.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                widget.img,
                width: 25.w,
                height: 25.w,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 1.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.libelle,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _showConfirmationDialog(context),
                          child: SvgPicture.asset(
                            'assets/icons/trash.svg',
                            width: 7.w,
                            height: 7.w,
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
                    SizedBox(height: 0.5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        AddPage(
                          userId: widget.userId,
                          partId: widget.partId,
                          initialQuantity: widget.quantite,
                          quantity: widget.quantite,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmer la suppression'),
          content: const Text(
              'Êtes-vous sûr de vouloir supprimer cet article du panier ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialogue
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialogue
                widget.onRemove(userIdConnect,
                    widget.partId); // Appelle la fonction de suppression
              },
              child: const Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }
}
