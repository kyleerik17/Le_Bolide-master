// import 'package:flutter/material.dart';
// import 'package:Bolide/screens/src/features/Pages/Home/Pay/Pages/checkout3_page.dart';
// import 'package:sizer/sizer.dart';

// Widget buildTotalWidget(
//   Order order,
// ) {
//   return Container(
//     height: 40.w,
//     width: double.infinity,
//     color: Colors.white,
//     child: Column(
//       children: [
//         SizedBox(height: 3.w),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 4.w),
//               child: Text('Sous-total',
//                   style: TextStyle(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w400,
//                       fontFamily: 'Poppins')),
//             ),
//             Padding(
//               padding: EdgeInsets.only(right: 4.w),
//               child: Text(' ${order.totalPrice} FCFA',
//                   style: TextStyle(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Cabin')),
//             ),
//           ],
//         ),
//         SizedBox(height: 1.h),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 4.w),
//               child: Text('Frais de livraison',
//                   style: TextStyle(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w400,
//                       fontFamily: 'Poppins')),
//             ),
//             Padding(
//               padding: EdgeInsets.only(right: 4.w),
//               child: Text('Gratuit',
//                   style: TextStyle(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Cabin')),
//             ),
//           ],
//         ),
//         SizedBox(height: 1.h),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 4.w),
//               child: Text('Code promo',
//                   style: TextStyle(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w400,
//                       fontFamily: 'Poppins')),
//             ),
//             Padding(
//               padding: EdgeInsets.only(right: 4.w),
//               child: Text('BOL10 (-10%)',
//                   style: TextStyle(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Cabin')),
//             ),
//           ],
//         ),
//         SizedBox(height: 1.h),
//         Container(
//           child: Center(
//             child: SizedBox(
//               width: 88.w,
//               child: Divider(
//                 height: 2.h,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: 1.h),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 4.w),
//               child: Text('TOTAL',
//                   style: TextStyle(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Poppins')),
//             ),
//             Padding(
//               padding: EdgeInsets.only(right: 4.w),
//               child: Text(' ${order.totalPrice} FCFA',
//                   style: TextStyle(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Poppins')),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }


