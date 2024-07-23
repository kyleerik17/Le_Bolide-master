// lib/src/features/Pages/Home/Pay/Widgets/formulaire_livraison.dart

import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../../../Widgets/inputs/inputs.dart';

class FormulaireLivraison extends StatelessWidget {
  const FormulaireLivraison({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
 SizedBox(height: 2.h),
                Text(
                  'Nom(s) *',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 1.h),
                InputText(
                  hintText: "",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(0.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 3.w),
                        Text(
                          "Diallo ",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Cabin",
                          ),
                        ),
                      ],
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 1.5.h),
                        Image.asset(
                          'assets/icons/check.png',
                          width: 5.w,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Prénom(s) *',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 1.h),
                InputText(
                  hintText: "",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(0.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 3.w),
                        Text(
                          "Fanta",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Cabin",
                          ),
                        ),
                      ],
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 1.5.h),
                        Image.asset(
                          'assets/icons/check.png',
                          width: 5.w,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Adresse Email',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 1.h),
                InputText(
                  hintText: "",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(0.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 3.w),
                        Text(
                          "fanta.d@gmail.com ",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Cabin",
                          ),
                        ),
                      ],
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 1.5.h),
                        Image.asset(
                          'assets/icons/check.png',
                          width: 5.w,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Pays *',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 1.h),
                InputText(
                  hintText: "",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(0.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 3.w),
                        Text(
                          "Sénégal ",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Cabin",
                          ),
                        ),
                      ],
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 1.5.h),
                        Image.asset(
                          'assets/icons/check.png',
                          width: 5.w,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Adresse *',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 1.h),
                InputText(
                  hintText: "",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(0.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 3.w),
                        Text(
                          "Hann Maristes, Rte Brioche Dorée, Z98  ",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Cabin",
                          ),
                        ),
                      ],
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 1.5.h),
                        Image.asset(
                          'assets/icons/check.png',
                          width: 5.w,
                        ),
                      ],
                    ),
                  ),
                ),
        
        SizedBox(height: 1.h),
        
      ],
    );
  }
}