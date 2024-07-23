import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../Home/Pay/Widgets/buildStep.dart';
import 'commande_page.dart';

class DetailsCommandePage extends StatelessWidget {
  const DetailsCommandePage(
      {super.key, required String price, required String description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CommandePage()),
            );
          },
          child: Container(
            padding: EdgeInsets.all(0.w),
            child: Image.asset(
              'assets/icons/gc.png',
              width: 12.w,
              height: 12.w,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Détails commande',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFF7F8F9),
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.w),
            Text(
              'Statut de la commande',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins'),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                SizedBox(width: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.2.w),
                  child: Image.asset(
                    'assets/icons/cs.png',
                  ),
                ),
                SizedBox(
                  width: 33.w,
                  child: const Divider(
                    color: Colors.grey,
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.2.w),
                  child: Image.asset(
                    'assets/icons/cs1.png',
                  ),
                ),
                SizedBox(
                  width: 33.w,
                  child: const Divider(
                    color: Colors.grey,
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.2.w),
                  child: Image.asset(
                    'assets/icons/cs2.png',
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildStep(' Préparation'),
                buildStep('Envoie'),
                buildStep('Effectuée'),
              ],
            ),
            SizedBox(height: 2.h),
            const Text(
              'Reception prévue pour le Mardi 25 Juin à 16:00',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Cabin',
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 2.h),
            Text(
              'Récapitulatif',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins"),
            ),
            SizedBox(height: 1.h),
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.w),
                  color: Colors.white),
              child: Row(
                children: [
                  Image.asset('assets/images/pn2.png',
                      width: 20.w, height: 20.w),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Radar Rivera PRO 2 165/65 R13 77T',
                                style: TextStyle(fontSize: 12.sp),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/sun.png',
                              color: Colors.black,
                              width: 4.w,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              'Pneu été',
                              style: TextStyle(
                                fontFamily: "Cabin",
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          '38 000 F',
                          style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(height: 1.h),
                            Image.asset(
                              'assets/icons/trash.png',
                            ),
                          ]),
                      SizedBox(height: 5.h),
                      Container(
                        width: 12.w,
                        height: 6.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.h, vertical: 0.3.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(1.5.w),
                        ),
                        child: Text(
                          '2',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              height: 40.w,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 5.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Text('Sous-total',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: Text('76 000 F',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Cabin')),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Text('Frais de livraison',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: Text('Gratuit',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Cabin')),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Text('Code promo',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: Text('BOL10 (-10%)',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Cabin')),
                      ),
                    ],
                  ),
                  Center(
                    child: SizedBox(
                      width: 88.w,
                      child: Divider(
                        height: 2.h,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Text('TOTAL',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: Text('68 400 F',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
