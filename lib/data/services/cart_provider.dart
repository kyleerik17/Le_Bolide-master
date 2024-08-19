import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<dynamic> _cartItems = [];

  List<dynamic> get cartItems => _cartItems;

  bool get isCartEmpty => _cartItems.isEmpty;

  void addItem(dynamic item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeItem(dynamic item) {
    _cartItems.remove(item);
    notifyListeners();
  }
}
