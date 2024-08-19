import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveCartItems(List<Map<String, dynamic>> cartItems) async {
  final prefs = await SharedPreferences.getInstance();
  // Convertir les données en JSON et les stocker
  prefs.setString('cart_items', jsonEncode(cartItems));
}
