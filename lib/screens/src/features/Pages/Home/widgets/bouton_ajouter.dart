import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:le_bolide/screens/src/features/Pages/Home/widgets/detail_produit.dart';
import 'dart:convert';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class QuantityWidget extends StatefulWidget {
  final String partId; // ID de l'article

  QuantityWidget({
    Key? key,
    required this.partId, required String userId,
  }) : super(key: key);

  @override
  _QuantityWidgetState createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  bool _showQuantityControls = false;
  int _quantity = 1;
  
  final String _userId = '2'; // ID utilisateur fixe

  // Function to send quantity update to the API
  Future<void> _sendQuantityUpdate() async {
  const url = 'http://192.168.1.11/rest-api/api/cart/add';

  final data = {
    'user_id': _userId,
    'part_id': widget.partId,
    'quantity': _quantity.toString(),
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Quantité mise à jour avec succès: user_id: ${data['user_id']}, part_id: ${data['part_id']}, quantity: ${data['quantity']}');
    } else {
      print('Échec de la mise à jour de la quantité, code de statut: ${response.statusCode}');
    }
  } catch (e) {
    print('Erreur lors de l\'envoi de la requête: $e');
  }
}

  // Increment quantity and possibly navigate to another page
  void _incrementQuantity() {
    if (_quantity < 2) {
      setState(() {
        _quantity++;
      });
      _sendQuantityUpdate().then((_) {
        print('user_id: $_userId, part_id: ${widget.partId}, quantity: $_quantity');
        if (_quantity >= 3) {
          _navigateToPay1Page();
        }
      });
    }
  }

  // Decrement quantity and possibly hide controls
  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
      _sendQuantityUpdate().then((_) {
        print('user_id: $_userId, part_id: ${widget.partId}, quantity: $_quantity');
      });
    } else {
      setState(() {
        _quantity = 1; // Ensure quantity doesn't go below 1
        _showQuantityControls = false; // Hide controls and show "Ajouter" button
      });
      _sendQuantityUpdate().then((_) {
        print('user_id: $_userId, part_id: ${widget.partId}, quantity: $_quantity');
      });
    }
  }

  // Navigate to another page with animation
  void _navigateToPay1Page() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const Details1ProduitsPage(),
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

  // Toggle the visibility of quantity controls
  void _toggleQuantityControls() {
    setState(() {
      _showQuantityControls = !_showQuantityControls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 4.2.h,
        child: !_showQuantityControls
            ? SizedBox(
                child: TextButton(
                  onPressed: () {
                    _toggleQuantityControls();
                    print('Article ajouté avec quantité $_quantity');
                    _sendQuantityUpdate().then((_) {
                      print('user_id: $_userId, part_id: ${widget.partId}, quantity: $_quantity');
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 6.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.5.w),
                    ),
                  ),
                  child: Text(
                    "Ajouter",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Cabin',
                    ),
                  ),
                ),
              )
            : Container(
                padding: EdgeInsets.symmetric(vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(1.5.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        _decrementQuantity();
                        print('user_id: $_userId, part_id: ${widget.partId}, quantity: $_quantity');
                      },
                      icon: const Icon(Icons.remove),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                    VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                      width: 0.w,
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Text(
                      '$_quantity',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                      width: 2.w,
                    ),
                    IconButton(
                      onPressed: () {
                        _incrementQuantity();
                        print('user_id: $_userId, part_id: ${widget.partId}, quantity: $_quantity');
                      },
                      icon: const Icon(Icons.add),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
