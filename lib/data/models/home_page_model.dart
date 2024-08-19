// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:Bolide/data/services/user.dart';

// class HomePageModel with ChangeNotifier {
//   List<String> cartItems = [];
//   User? user;

//   Future<void> loadCartItems() async {
//     final prefs = await SharedPreferences.getInstance();
//     cartItems = prefs.getStringList('cartItems') ?? [];
//     notifyListeners();
//   }

//   Future<void> loadUser(User user) async {
//     this.user = user;
//     notifyListeners();
//   }

//   Future<void> addToCart(String item) async {
//     cartItems.add(item);
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('cartItems', cartItems);
//     notifyListeners();
//   }

//   bool isCartEmpty() {
//     return cartItems.isEmpty;
//   }
// }
