import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../Widgets/TotalWidget.dart';
import '../Widgets/buildStep.dart';
import '../Widgets/widgets.dart';

class Pay3Page extends StatelessWidget {
  const Pay3Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSecurePaymentWidget(),
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
                ],
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildStep('  Livraison'),
                  buildStep('Paiement'),
                  buildStep('Confirmation'),
                ],
              ),
              SizedBox(height: 3.h),
              Text(
                "Commande validée",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Merci, votre commande a été validée avec succès. Vous recevrez des notifications pour suivre l'évolution de votre commande, ou consultez l'onglet “Commandes”",
                style: TextStyle(
                  fontSize: 10.sp,
                  color: const Color(0xff1A1A1A),
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/rec.png',
                          width: 8.w,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          'Commande XDR 980 992',
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(width: 30.w),
                        Image.asset(
                          'assets/icons/fw.png',
                          color: Colors.black,
                          width: 2.5.w,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Récapitulatif",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: 1.h),
              buildOrderSummaryWidget(),
              SizedBox(height: 1.h),
              buildTotalWidget(),
              SizedBox(height: 2.h),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const FindSearchPlusPage()),
                    // );
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
                        "Terminer",
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
      ),
    );
  }
}
