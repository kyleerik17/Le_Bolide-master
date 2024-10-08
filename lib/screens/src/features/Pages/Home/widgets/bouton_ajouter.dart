import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:Bolide/data/models/api_services.dart';
import 'package:Bolide/data/services/user.dart';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/detail_produit.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class QuantityWidget extends StatefulWidget {
  final int partId;
  final int userId;
  const QuantityWidget({Key? key, required this.partId, required this.userId})
      : super(key: key);

  @override
  _QuantityWidgetState createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  bool _showQuantityControls = false;
  int _quantity = 0;
  late User user;

  @override
  void initState() {
    super.initState();
    try {
      user = GetIt.instance.get<User>();
      print('User name: ${user.name}');
      print('User ID: ${user.id}');
    } catch (e) {
      print('Error retrieving user: $e');
    }
  }

  // Function to send quantity update to the API
  Future<void> _sendQuantityUpdate() async {
    final url = '${baseUrl}api/cart/add/';

    final data = {
      'user_id': user.id.toString(),
      'part_id': widget.partId.toString(),
      'quantity': _quantity.toString(),
    };

    try {
      print('Sending request to $url');
      print('Data sent: ${jsonEncode(data)}');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data),
      );

      print('Status code received: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print(
            'Quantity updated successfully: user_id: ${data['user_id']}, part_id: ${data['part_id']}, quantity: ${data['quantity']}');
      } else {
        print('Failed to update quantity, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending request: $e');
    }
  }

  // Remove item from cart
  Future<void> _removeFromCart() async {
    final url = '${baseUrl}api/cart/remove/';
    final data = {
      'user_id': user.id.toString(),
      'part_id': widget.partId.toString(),
    };

    try {
      print('Sending request to $url');
      print('Data sent: ${jsonEncode(data)}');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data),
      );

      print('Status code received: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Item removed from cart successfully');
      } else {
        print(
            'Failed to remove item from cart, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending request: $e');
    }
  }

  // Decrement quantity and possibly remove from cart
  Future<void> _decrementQuantity() async {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
      });
      await _sendQuantityUpdate();
      print(
          'user_id: ${user.id}, part_id: ${widget.partId}, quantity: $_quantity');
      if (_quantity == 1) {
        await _removeFromCart();
        setState(() {
          _showQuantityControls =
              false; // Hide controls and show "Ajouter" button
        });
      }
      _showAlert('Le produit a bien été retiré');
    }
  }

  // Increment quantity and possibly navigate to another page
  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
    _sendQuantityUpdate().then((_) {
      print(
          'user_id: ${user.id}, part_id: ${widget.partId}, quantity: $_quantity');
      _showAlert('Le produit a bien été ajouté');
    });
  }

  // Function to show alert message
  void _showAlert(String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 20.0,
        left: MediaQuery.of(context).size.width * 0.25,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Colors.black.withOpacity(0.7),
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
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
                    print('Article added with quantity $_quantity');
                    _sendQuantityUpdate().then((_) {
                      print(
                          'user_id: ${user.id}, part_id: ${widget.partId}, quantity: $_quantity');
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    padding:
                        EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 6.w),
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
