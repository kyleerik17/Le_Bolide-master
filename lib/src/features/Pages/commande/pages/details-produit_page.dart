import 'package:flutter/material.dart';
import 'package:le_bolide/src/features/Pages/Home/Pay/Pages/checkout_page.dart';
import 'package:le_bolide/src/features/Pages/commande/widgets/slider1.dart';
import 'package:sizer/sizer.dart';

import '../../Home/widgets/bouton_ajouter.dart';


class DetailsProduitsPage extends StatelessWidget {
  const DetailsProduitsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PayPage(),
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
          'Détails produit',
          style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins'),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF7F8F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          Text(
                            "Radar Rivera PRO 2 165/65 R13 77T",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 0.5.h),
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
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/icons/oc1.png',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: const Slider1Page(),
              ),
              SizedBox(height: 2.h),
              _buildReservationContainer(context),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReservationContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "38 000 F",
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      fontFamily: "Cabin",
                    ),
                  ),
                ],
              ),
              QuantityWidget()
            ],
          ),
          SizedBox(height: 1.h),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
            height: 1,
          ),
          SizedBox(height: 1.h),
          Text(
            'Description',
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: 'Cabin',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 1.h),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color(0xFF7C7C7C),
                fontFamily: 'Cabin',
                fontWeight: FontWeight.w400,
              ),
              children: [
                const TextSpan(
                  text:
                      "Ces pneus sont parfaits pour une utilisation sur terrains difficiles et c'est avec une puissance de ",
                ),
                TextSpan(
                  text: "... voir plus",
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
            height: 1,
          ),
          SizedBox(height: 1.h),
          Text(
            'Caractéristiques',
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: 'Cabin',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 1.5.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCharacteristicRow('Longueur', '120 cm',
                  backgroundColor: Colors.grey[200]),
              SizedBox(height: 0.5.h),
              _buildCharacteristicRow('Largeur', '60 cm'),
              SizedBox(height: 0.5.h),
              _buildCharacteristicRow('Hauteur', '40 cm',
                  backgroundColor: Colors.grey[200]),
              SizedBox(height: 0.5.h),
              _buildCharacteristicRow('Poids', '24 kg'),
              SizedBox(height: 0.5.h),
              _buildCharacteristicRow('Alimentation', 'Essence',
                  backgroundColor: Colors.grey[200]),
              SizedBox(height: 0.5.h),
              _buildCharacteristicRow(
                'Ref.fabriquant',
                '5677',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCharacteristicRow(String title, String description,
      {Color? backgroundColor}) {
    return Container(
      color: backgroundColor ?? Colors.transparent,
      width: double.infinity,
      height: 4.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '  $title',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Cabin',
              color: Colors.black,
              fontSize: 12.sp,
            ),
          ),
          Text(
            '$description  ',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: 'Cabin',
              color: const Color(0xFF7C7C7C),
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
