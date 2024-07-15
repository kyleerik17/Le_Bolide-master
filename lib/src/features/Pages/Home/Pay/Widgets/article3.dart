import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_bolide/src/features/Pages/Home/Pay/Widgets/add.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/bouton_ajouter.dart';

class Article3Page extends StatelessWidget {
  const Article3Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 4.w),
        _buildArticle(
          imageUrl: 'assets/images/pn2.png',
          title: 'Radar Rivera PRO 2 165/65\nR13 77T',
          iconUrl: 'assets/icons/sun.png',
          description: 'Pneu été',
          price: '38 000 F',
        ),
        SizedBox(height: 4.w),
        _buildArticle(
          imageUrl: 'assets/images/pn2.png',
          title: 'Radar Rivera PRO 2 165/65\nR13 77T',
          iconUrl: 'assets/icons/sun.png',
          description: 'Pneu été',
          price: '38 000 F',
        ),
      ],
    );
  }

  Widget _buildArticle({
    required String imageUrl,
    required String title,
    required String iconUrl,
    required String description,
    required String price,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 92.w,
          height: 30.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0.5.h),
          ),
          padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 4.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 20.w,
                height: 25.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(0.5.h),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: "Cabin",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 1.w),
                    Row(
                      children: [
                        Image.asset(
                          iconUrl,
                          width: 6.w,
                          height: 6.w,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: "Cabin",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          price,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: "Cabin",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const AddPage()
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
