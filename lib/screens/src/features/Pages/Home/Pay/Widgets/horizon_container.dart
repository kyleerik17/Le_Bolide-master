import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ContaiRizon extends StatelessWidget {
  const ContaiRizon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: [
          Container(
            width: 45.w,
            height: 75.w,
            margin: const EdgeInsets.only(right: 12),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
              ),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Image.asset(
                      'assets/images/fr.jpeg',
                      width: 84,
                      height: 84,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 1.w),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text(
                    'RIDEX 3405B1\nDisques et\nplaquettes de freins',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Cabin',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 1.w),
                Row(
                  children: [
                    SizedBox(width: 2.w),
                    Image.asset(
                      'assets/icons/ea.png',
                      color: const Color(0xFF1A1A1A),
                      width: 4.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Essieu arrière',
                      style: TextStyle(
                        fontFamily: "Cabin",
                        color: const Color(0xFF1A1A1A),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.w),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text(
                    '69 000 F',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 1.w),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF1A1A1A),
                      padding:
                          EdgeInsets.symmetric(horizontal: 11.w, vertical: 1.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.5.w),
                      ),
                      minimumSize: const Size(0, 0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Ajouter",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontFamily: 'Cabin',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 45.w,
            height: 75.w,
            margin: const EdgeInsets.only(right: 12),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
              ),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Image.asset(
                      'assets/images/fr.jpeg',
                      width: 84,
                      height: 84,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 1.w),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text(
                    'RIDEX 3405B1\nDisques et\nplaquettes de freins',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Cabin',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 1.w),
                Row(
                  children: [
                    SizedBox(width: 2.w),
                    Image.asset(
                      'assets/icons/ea.png',
                      color: const Color(0xFF1A1A1A),
                      width: 4.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Essieu arrière',
                      style: TextStyle(
                        fontFamily: "Cabin",
                        color: const Color(0xFF1A1A1A),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.w),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text(
                    '69 000 F',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 1.w),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF1A1A1A),
                      padding:
                          EdgeInsets.symmetric(horizontal: 11.w, vertical: 1.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.5.w),
                      ),
                      minimumSize: const Size(0, 0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Ajouter",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontFamily: 'Cabin',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
