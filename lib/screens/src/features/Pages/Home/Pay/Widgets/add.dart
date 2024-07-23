import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:le_bolide/screens/src/features/Pages/Home/widgets/detail_produit.dart';
import 'dart:convert';
import 'package:sizer/sizer.dart';

class AddPage extends StatefulWidget {
  final String userId; // ID de l'utilisateur
  final String partId; // ID de l'article

  const AddPage({
    Key? key,
    required this.userId,
    required this.partId,
  }) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  bool _showQuantityControls = false;
  int _quantity = 1;

  Future<void> _sendQuantityUpdate() async {
    final url = 'http://192.168.1.11/rest-api/api/cart/add';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'user_id': widget.userId,
        'part_id': widget.partId,
        'quantity': _quantity.toString(),
      }),
    );

    if (response.statusCode == 200) {
      print('Quantité mise à jour avec succès: $_quantity');
    } else {
      print('Échec de la mise à jour de la quantité');
    }
  }

  void _incrementQuantity() {
    setState(() {
      if (_quantity < 2) {
        _quantity++;
        _sendQuantityUpdate().then((_) {
          print(
              'user_id: ${widget.userId}, part_id: ${widget.partId}, quantity: $_quantity');
        });
      } else {
        _navigateToPay1Page();
      }
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
        _sendQuantityUpdate().then((_) {
          print(
              'user_id: ${widget.userId}, part_id: ${widget.partId}, quantity: $_quantity');
        });
      } else {
        _showQuantityControls = false;
        _quantity = 1;
        _sendQuantityUpdate().then((_) {
          print(
              'user_id: ${widget.userId}, part_id: ${widget.partId}, quantity: $_quantity');
        });
      }
    });
  }

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
                  onPressed: _toggleQuantityControls,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    padding:
                        EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 12.w),
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
                      onPressed: _decrementQuantity,
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
                      onPressed: _incrementQuantity,
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
