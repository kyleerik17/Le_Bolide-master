import 'package:flutter/material.dart';
import 'package:le_bolide/src/features/Pages/Search/Pages/find_search_page.dart';
import 'package:sizer/sizer.dart';

class Search1BarWidget extends StatelessWidget {
  const Search1BarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(1.h),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: 'Pneus',
        hintStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins',
          fontSize: 11.sp,
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
