import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:Bolide/data/models/api_services.dart';
import 'package:Bolide/data/services/user.dart';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/detail_produit.dart';
import 'package:Bolide/screens/src/features/Pages/commande/pages/details-produit_page.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class Quantity1Widget extends StatefulWidget {
  final int partId;
  final int userId;
  const Quantity1Widget({Key? key, required this.partId, required this.userId})
      : super(key: key);

  @override
  _Quantity1WidgetState createState() => _Quantity1WidgetState();
}

class _Quantity1WidgetState extends State<Quantity1Widget> {
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
    const url = '${baseUrl}api/cart/add/';

    final data = {
      'user_id': user.id.toString(), // Utiliser user.id ici
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
        // Add more details if possible from the response body
      }
    } catch (e) {
      print('Error sending request: $e');
    }
  }

  // Increment quantity and possibly navigate to another page
  void _incrementQuantity() {
    if (_quantity < 2) {
      setState(() {
        _quantity++;
      });
      _sendQuantityUpdate().then((_) {
        print(
            'user_id: ${user.id}, part_id: ${widget.partId}, quantity: $_quantity');
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
        print(
            'user_id: ${user.id}, part_id: ${widget.partId}, quantity: $_quantity');
      });
    } else {
      setState(() {
        _quantity = 1; // Ensure quantity doesn't go below 1
        _showQuantityControls =
            false; // Hide controls and show "Ajouter" button
      });
      _sendQuantityUpdate().then((_) {
        print(
            'user_id: ${user.id}, part_id: ${widget.partId}, quantity: $_quantity');
      });
    }
  }

  // Navigate to another page with animation

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
                        EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 8.w),
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
                        print(
                            'user_id: ${user.id}, part_id: ${widget.partId}, quantity: $_quantity');
                      },
                      icon: const Icon(Icons.remove),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                    VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                      width: 1.w,
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
                        print(
                            'user_id: ${user.id}, part_id: ${widget.partId}, quantity: $_quantity');
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
