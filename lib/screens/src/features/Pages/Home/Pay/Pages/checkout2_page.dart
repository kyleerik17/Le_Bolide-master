import 'package:flutter/material.dart';


import 'package:sizer/sizer.dart';

import 'checkout3_page.dart';
import 'checkout_page.dart';

class Pay2Page extends StatelessWidget {
  const Pay2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PayPage(partId: '',),
              ),
            );
          },
          child: Image.asset(
            'assets/icons/gc.png',
            width: 15.w,
            height: 15.w,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Paiement',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 0.w),
              child: Row(
                children: [
                  SizedBox(width: 2.w),
                  Image.asset(
                    'assets/icons/lgo.png',
                    width: 8.w,
                  ),
                  SizedBox(width: 35.w),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/lock.png',
                        width: 8.w,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Paiement sécurisé',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),
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
                  width: 30.w,
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
                _buildStep('  Livraison'),
                _buildStep('Paiement'),
                _buildStep('Confirmation'),
              ],
            ),
            SizedBox(height: 3.h),
            const Text(
              'Choisissez un moyen de paiement',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins"),
            ),
            SizedBox(height: 2.h),
            PaymentOptionRow(
              label: 'Wave',
              imagePath: 'assets/images/wave.png',
              imageWidth: 10.w,
              height: 10.w,
              onTap: () {},
            ),
            PaymentOptionRow(
              label: 'Max it',
              imagePath: 'assets/images/orange.png',
              imageWidth: 10.w,
              height: 10.w,
              onTap: () {},
            ),
            PaymentOptionRow(
              label: 'Orange Money (Application)',
              imagePath: 'assets/images/om.png',
              imageWidth: 10.w,
              height: 10.w,
              onTap: () {},
            ),
            PaymentOptionRow(
              label: 'Orange Money (USSD)',
              imagePath: 'assets/images/om.png',
              imageWidth: 10.w,
              height: 10.w,
              onTap: () {},
            ),
            PaymentOptionRow(
              label: 'Carte bancaire',
              imagePath: 'assets/icons/card.png',
              imageWidth: 10.w,
              height: 10.w,
              onTap: () {},
            ),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Pay3Page()),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF1A1A1A),
                  padding:
                      EdgeInsets.symmetric(vertical: 1.h, horizontal: 20.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.w),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Continuer",
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
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String title) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12.sp),
        ),
      ],
    );
  }
}

class PaymentOptionRow extends StatelessWidget {
  final String label;
  final String imagePath;
  final double? imageWidth;
  final VoidCallback onTap;

  const PaymentOptionRow({
    Key? key,
    required this.label,
    required this.imagePath,
    this.imageWidth,
    required this.onTap,
    required double height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        margin: EdgeInsets.symmetric(vertical: 1.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(1.w),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: imageWidth ?? 12.w,
              height: 8.w,
            ),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Cabin',
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 4.w,
            ),
          ],
        ),
      ),
    );
  }
}
