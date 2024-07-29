
// import 'package:flutter/material.dart';

// import 'package:sizer/sizer.dart';

// import '../../registration/pages/pages.dart';
// import 'onboarding2_page.dart';

// class Onboarding3Page extends StatefulWidget {
//   const Onboarding3Page({Key? key}) : super(key: key);

//   @override
//   State<Onboarding3Page> createState() => _Onboarding3PageState();
// }

// double loadingProgress = 100 / 100.0;

// class _Onboarding3PageState extends State<Onboarding3Page> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(4.w),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back_ios),
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         PageRouteBuilder(
//                           transitionDuration: const Duration(milliseconds: 300),
//                           pageBuilder: (_, __, ___) => const Onboarding2Page(),
//                           transitionsBuilder: (_, animation, __, child) {
//                             return SlideTransition(
//                               position: Tween<Offset>(
//                                 begin: const Offset(1.0, 0.0),
//                                 end: Offset.zero,
//                               ).animate(animation),
//                               child: child,
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                   SizedBox(width: 11.h),
//                   Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "book ",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 20.sp,
//                             fontFamily: "Poppins",
//                             letterSpacing: 0.05,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         Text(
//                           "it",
//                           style: TextStyle(
//                             color: Color(0xFFEA7C17),
//                             fontWeight: FontWeight.w600,
//                             fontSize: 20.sp,
//                             fontFamily: "Poppins",
//                             letterSpacing: 0.05,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 5.h),
//               Container(
//                 width: 80.w,
//                 child: LinearProgressIndicator(
//                   value: loadingProgress,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 2.h),
//               Text(
//                 "Gérez vos réservations et vos préférences en toute facilité !",
//                 style: TextStyle(
//                   fontSize: 23.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 3.h),
//               Image.asset(
//                 'assets/icons/tools.gif',
//                 width: 58.w,
//                 height: 37.h,
//                 fit: BoxFit.contain,
//               ),
//               SizedBox(height: 5.h),
//               Text(
//                 "Suivez votre historique, modifiez vos informations et profitez de programmes de fidélité exclusifs.",
//                 style: TextStyle(
//                   fontSize: 12.sp,
//                   fontFamily: "Cabin",
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 5.h),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                       context,
//                       PageRouteBuilder(
//                         transitionDuration: const Duration(milliseconds: 300),
//                         pageBuilder: (_, __, ___) =>
//                             const RegistrationPage(),
//                         transitionsBuilder: (_, animation, __, child) {
//                           return SlideTransition(
//                             position: Tween<Offset>(
//                               begin: const Offset(1.0, 0.0),
//                               end: Offset.zero,
//                             ).animate(animation),
//                             child: child,
//                           );
//                         },
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFFEA7C17),
//                     padding:
//                         EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 13.h),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(1.h),
//                     ),
//                   ),
//                   child: Text(
//                     "Démarrer",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 12.sp,
//                         fontFamily: "Cabin",
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
