import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:le_bolide/src/features/Pages/loading%20modal/pages/resultat_search2_page.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showLoadingDialog(context);
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchResult2Page(),
            ),
          );
        });
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.w),
          color: const Color(0xFF232323),
        ),
        padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 2.w),
        child: Center(
          child: Text(
            'Rechercher',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Cabin',
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
            ),
          ),
        ),
      ),
    );
  }
}
void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.all(0),
          child: Container(
            alignment: Alignment.center,
                 color: Colors.transparent,
            child: SizedBox(
              width: 20.w,
              height: 20.w,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                strokeWidth: 6,
              ),
            ),
          ),
        );
      },
    );
  }