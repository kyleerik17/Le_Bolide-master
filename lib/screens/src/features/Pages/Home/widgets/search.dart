import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../Search/Pages/find_search_page.dart';

class SearchBarWidget extends StatelessWidget {
  final int partId;
  final int userId;
  const SearchBarWidget({
    Key? key,
    required this.partId,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 300),
            pageBuilder: (_, __, ___) => FindSearchPage(
              partId: partId,
              userId: userId,
            ),
            transitionsBuilder: (_, animation, __, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 1.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
        );
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(1.h),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: 'Rechercher...',
        hintStyle: TextStyle(
          color: const Color(0xFF737373),
          fontFamily: 'Poppins',
          fontSize: 10.sp,
        ),
        prefixIcon: ImageIcon(
          const AssetImage('assets/icons/search.png'),
          size: 5.w,
          color: Colors.black,
        ),
        suffixIcon: ImageIcon(
          const AssetImage('assets/icons/mc.png'),
          size: 5.w,
          color: Colors.black,
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }
}
