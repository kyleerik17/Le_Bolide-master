import 'package:flutter/material.dart';
import 'package:Bolide/screens/src/features/Pages/loading%20modal/pages/resultat_search_page.dart';
import 'package:sizer/sizer.dart';
import 'loading_dialog.dart';

class ChassisNumber extends StatelessWidget {
  final int userId;
  final int partId;
  const ChassisNumber({Key? key, required this.userId, required this.partId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Numéro de châssis',
              style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 1.w),
            Image.asset(
              'assets/icons/Icon.png',
              height: 4.w,
              width: 4.w,
            ),
          ],
        ),
        SizedBox(height: 1.h),
        GestureDetector(
          onTap: () {
            _showLoadingDialog(context);
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchResultPage(
                    partId: partId,
                    userId: userId,
                  ),
                ),
              );
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(1.5.w),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/key.png',
                  height: 4.w,
                  width: 4.w,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    'KM8 SRDHF5 EU123456',
                    style: TextStyle(
                      color: const Color(0xFF94979E),
                      fontFamily: 'Cabin',
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
