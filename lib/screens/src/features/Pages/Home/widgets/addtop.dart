// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:http/http.dart' as http;
// import 'package:Bolide/data/services/user.dart';
// import 'package:Bolide/screens/src/features/Pages/Home/widgets/detail_produit.dart';
// import 'package:sizer/sizer.dart';

// class ADTP extends StatefulWidget {
//   final int quantity; // Quantité initiale
//   final int partId;
//   final int userId;

//   const ADTP({
//     Key? key,
//     required this.userId,
//     required this.partId,
//     required this.quantity,
//     required int initialQuantity,
//   }) : super(key: key);

//   @override
//   _ADTPState createState() => _ADTPState();
// }

// class _ADTPState extends State<ADTP> {
//   int _quantity = 0; // Quantité actuelle
//   late User user;
//   final int maxQuantity = 99;

//   @override
//   void initState() {
//     super.initState();
//     try {
//       user = GetIt.instance.get<User>();
//       print('ID utilisateur de GetIt: ${user.id}');
//       print('Nom utilisateur de GetIt: ${user.name}');
//     } catch (e) {
//       print('Erreur lors de la récupération de l\'utilisateur: $e');
//     }
//     _quantity = widget
//         .quantity; // Initialiser la quantité avec celle passée en paramètre
//     print('Quantité initiale: $_quantity');
//   }

//   Future<void> _sendQuantityUpdate() async {
//     final url =
//         'https://bolide.armasoft.ci/bolide_services/index.php/api/cart/add';

//     final data = {
//       'user_id': user.id.toString(),
//       'part_id': widget.partId.toString(),
//       'quantity': _quantity.toString(),
//     };

//     print('Envoi de la mise à jour - Données: ${jsonEncode(data)}');

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//         body: jsonEncode(data),
//       );

//       print('Code de statut de la réponse: ${response.statusCode}');
//       print('Corps de la réponse: ${response.body}');

//       if (response.statusCode == 200) {
//         _showSnackBar('Le produit a été mis à jour avec succès.');
//       } else {
//         print('Erreur API: ${response.body}');
//         throw Exception('Échec de la mise à jour de la quantité');
//       }
//     } catch (e) {
//       print('Erreur lors de l\'envoi de la requête: $e');
//       _showSnackBar('Erreur lors de la mise à jour. Veuillez réessayer.');
//     }
//   }

//   Future<void> _removeFromCart() async {
//     final url =
//         'https://bolide.armasoft.ci/bolide_services/index.php/api/cart/remove/';

//     final data = {
//       'user_id': user.id.toString(),
//       'part_id': widget.partId.toString(),
//     };

//     print('Suppression du panier - Données: ${jsonEncode(data)}');

//     try {
//       final response = await http.delete(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//         body: jsonEncode(data),
//       );

//       print('Code de statut de la suppression: ${response.statusCode}');
//       print('Corps de la réponse de suppression: ${response.body}');

//       if (response.statusCode == 200) {
//         _showSnackBar('Article supprimé du panier.');
//       } else {
//         print('Erreur API: ${response.body}');
//         throw Exception('Échec de la suppression de l\'article du panier');
//       }
//     } catch (e) {
//       print('Erreur lors de la suppression du panier: $e');
//       _showSnackBar('Erreur lors de la suppression. Veuillez réessayer.');
//     }
//   }

//   Future<void> _decrementQuantity() async {
//     print('Décrémentation - Quantité avant: $_quantity');
//     if (_quantity > 0) {
//       setState(() {
//         _quantity--;
//       });
//       print('Décrémentation - Nouvelle quantité: $_quantity');
//       await _sendQuantityUpdate();
//       if (_quantity == 0) {
//         await _removeFromCart();
//       } else {
//         _showSnackBar('La quantité a été réduite.');
//       }
//     }
//     print('Décrémentation - Quantité finale: $_quantity');
//   }

//   void _incrementQuantity() {
//     print('Incrémentation - Quantité avant: $_quantity');
//     if (_quantity < maxQuantity) {
//       setState(() {
//         _quantity++;
//       });
//       print('Incrémentation - Nouvelle quantité: $_quantity');
//       _sendQuantityUpdate().then((_) {
//         _showSnackBar('Le produit a été ajouté avec succès.');
//       });
//     } else {
//       _showSnackBar('Quantité maximale atteinte.');
//     }
//     print('Incrémentation - Quantité finale: $_quantity');
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SizedBox(
//         height: 4.2.h,
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 0.5.h),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(color: Colors.black),
//             borderRadius: BorderRadius.circular(1.5.w),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 onPressed: _decrementQuantity,
//                 icon: const Icon(Icons.remove),
//                 padding: EdgeInsets.zero,
//                 constraints: BoxConstraints(),
//               ),
//               VerticalDivider(
//                 color: Colors.grey,
//                 thickness: 1,
//                 width: 0.w,
//               ),
//               SizedBox(
//                 width: 3.w,
//               ),
//               Text(
//                 '$_quantity',
//                 style: TextStyle(fontSize: 14.sp),
//               ),
//               SizedBox(
//                 width: 3.w,
//               ),
//               VerticalDivider(
//                 color: Colors.grey,
//                 thickness: 1,
//                 width: 2.w,
//               ),
//               IconButton(
//                 onPressed: _incrementQuantity,
//                 icon: const Icon(Icons.add),
//                 padding: EdgeInsets.zero,
//                 constraints: BoxConstraints(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
