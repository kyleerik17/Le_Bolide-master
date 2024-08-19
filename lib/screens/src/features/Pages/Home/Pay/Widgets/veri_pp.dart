import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Utility function to get the appropriate icon based on cart state
String getCartIcon(bool hasItems) {
  return hasItems ? 'assets/icons/payfull.svg' : 'assets/icons/pay.svg';
}
