// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:http/http.dart' as http;
// import 'package:Bolide/screens/src/features/Pages/Home/pages/home_page.dart';
// import 'package:Bolide/screens/src/features/Pages/Home/widgets/bar_search1.dart';
// import 'package:Bolide/screens/src/features/Pages/Search/Pages/find_search_full_page.dart';
// import 'package:sizer/sizer.dart';
// import 'package:Bolide/screens/src/features/Pages/Search/Pages/modal2_page.dart';
// import 'package:Bolide/screens/src/features/Pages/Search/Pages/modal_page.dart';
// import 'package:Bolide/data/models/piece_api.dart';

// class FindSearchPage extends StatefulWidget {
//   const FindSearchPage({Key? key}) : super(key: key);

//   @override
//   _FindSearchPageState createState() => _FindSearchPageState();
// }

// class _FindSearchPageState extends State<FindSearchPage> {
//   String _selectedButton = 'Tout';
//   late Future<List<Piece>> _piecesFuture;

//   @override
//   void initState() {
//     super.initState();
//     _piecesFuture = _fetchPieces();
//   }

//   Future<List<Piece>> _fetchPieces() async {
//     try {
//       final response = await http.get(Uri.parse('http://192.168.1.3/rest-api/api/pieces'));
//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         if (jsonResponse.containsKey('Liste des pieces')) {
//           final List<dynamic> piecesList = jsonResponse['Liste des pieces'];
//           return piecesList.map((piece) => Piece.fromJson(piece)).toList();
//         } else {
//           throw Exception('Key "Liste des pieces" not found in response');
//         }
//       } else {
//         throw Exception('Failed to load pieces. Status code: ${response.statusCode}');
//       }
//     } catch (error) {
//       throw Exception('Error fetching pieces: $error');
//     }
//   }

//   void _onButtonPressed(String buttonName) {
//     setState(() {
//       _selectedButton = buttonName;
//     });

//     Future.microtask(() {
//       if (buttonName == 'Filtres') {
//         showModalBottomSheet(
//           context: context,
//           isScrollControlled: true,
//           builder: (BuildContext context) {
//             return const ModalPage();
//           },
//         );
//       } else if (buttonName == 'Trier par') {
//         showModalBottomSheet(
//           context: context,
//           builder: (BuildContext context) {
//             return const Modal2Page();
//           },
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(4.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               SizedBox(height: 6.w),
//               Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => const HomePage()),
//                     ),
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Color(0xFFEBEBEB),
//                       ),
//                       padding: EdgeInsets.all(0.w),
//                       child: Image.asset(
//                         'assets/icons/close.png',
//                         width: 12.w,
//                         height: 12.w,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 5.w),
//               const SearchBar1Widget(),
//               SizedBox(height: 2.w),
//               Row(
//                 children: [
//                   _buildFilterButton('Tout', _selectedButton == 'Tout'),
//                   Gap(2.w),
//                   _buildFilterButton('Filtres', false, true),
//                   Gap(2.w),
//                   _buildFilterButton('Trier par', false, true),
//                 ],
//               ),
//               SizedBox(height: 2.w),
//               FutureBuilder<List<Piece>>(
//                 future: _piecesFuture,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else if (snapshot.hasData) {
//                     return Column(
//                       children: snapshot.data!.map((piece) {
//                         return ArticleCard(
//                           imageUrl: piece.img,
//                           title: piece.libelle,
//                           description: piece.description,
//                           price: piece.price,
//                           onAddPressed: () {
//                             // Your add action here
//                           },
//                         );
//                       }).toList(),
//                     );
//                   } else {
//                     return const Center(child: Text('No data available'));
//                   }
//                 },
//               ),
//               SizedBox(height: 9.w),
//               Center(
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const FindSearchPage()),
//                     );
//                   },
//                   style: TextButton.styleFrom(
//                     backgroundColor: const Color(0xFF1A1A1A),
//                     padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 35.w),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(1.w),
//                     ),
//                   ),
//                   child: Text(
//                     "Charger plus",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: 'Cabin',
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   TextButton _buildFilterButton(String label, bool isSelected, [bool isIcon = false]) {
//     return TextButton(
//       style: TextButton.styleFrom(
//         backgroundColor: isSelected ? Colors.black : Colors.white,
//         side: const BorderSide(color: Colors.grey),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(0.5.h),
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 4.w),
//         minimumSize: Size(0, 3.8.h),
//       ),
//       onPressed: () => _onButtonPressed(label),
//       child: Row(
//         children: [
//           Text(
//             label,
//             style: TextStyle(color: isSelected ? Colors.white : Colors.black),
//           ),
//           if (isIcon)
//             Padding(
//               padding: EdgeInsets.only(left: 1.w),
//               child: Image.asset(
//                 'assets/icons/fltr.png',
//                 color: Colors.black,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class ArticleCard extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String description;
//   final String price;
//   final VoidCallback onAddPressed;

//   const ArticleCard({
//     Key? key,
//     required this.imageUrl,
//     required this.title,
//     required this.description,
//     required this.price,
//     required this.onAddPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           width: 92.w,
//           height: 30.w,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(0.5.h),
//           ),
//           padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 4.w),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 20.w,
//                 height: 25.w,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: NetworkImage(imageUrl),
//                     fit: BoxFit.contain,
//                   ),
//                   borderRadius: BorderRadius.circular(0.5.h),
//                 ),
//               ),
//               SizedBox(width: 2.w),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 13.sp,
//                         fontFamily: "Cabin",
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 1.w),
//                     Row(
//                       children: [
//                         Text(
//                           description,
//                           style: TextStyle(
//                             fontSize: 12.sp,
//                             fontFamily: "Cabin",
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           price,
//                           style: TextStyle(
//                             fontSize: 13.sp,
//                             fontFamily: "Cabin",
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: onAddPressed,
//                           child: Text('Ajouter'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
