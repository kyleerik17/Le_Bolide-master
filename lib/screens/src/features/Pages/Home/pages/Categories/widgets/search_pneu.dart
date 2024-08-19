import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sizer/sizer.dart';

class SearchPneu extends StatelessWidget {
  const SearchPneu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92.w,
      height: 40,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFCED0D4)),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
        ),
      ),
      child: TextField(
        onTap: () {},
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          hintText: 'Rechercher...',
          hintStyle: TextStyle(
            color: Color(0xFF737373),
            fontFamily: 'Cabin',
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 0),
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              width: 16,
              height: 16,
              color: Colors.black,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 8),
        ),
        style: const TextStyle(
          color: Color(0xFF737373),
        ),
      ),
    );
  }
}
