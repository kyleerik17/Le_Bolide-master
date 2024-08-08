import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:le_bolide/data/services/user.dart';
import 'package:le_bolide/screens/src/features/Pages/Favoris/Widgets/add3.dart';

import 'package:le_bolide/screens/src/features/Pages/Home/Pay/Widgets/add2.dart';
import 'package:sizer/sizer.dart';

Widget buildOrderSummaryWidget(List<Map<String, dynamic>> cartItems) {
  return Container(
    padding: EdgeInsets.all(0.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(0.w),
      color: Colors.white,
    ),
    child: Column(
      children: cartItems
          .map((item) => CartItem2Widget(
                img: item['img'] ?? '',
                libelle: item['libelle'] ?? '',
                prix: double.tryParse(item['prix'].toString()) ?? 0.0,
                quantite: int.tryParse(item['quantite'].toString()) ?? 0,
                partId: int.tryParse(item['id_produit'].toString()) ?? 0,
                userId: 0, // You can set this according to your logic
                onRemove: (userId, partId) {
                  // Define the removal logic here
                },
              ))
          .toList(),
    ),
  );
}

class CartItem2Widget extends StatefulWidget {
  final String img;
  final String libelle;
  final double prix;
  final int quantite;
  final int partId;
  final int userId;
  final Function(int userId, int partId) onRemove;

  CartItem2Widget({
    Key? key,
    required this.img,
    required this.libelle,
    required this.prix,
    required this.quantite,
    required this.partId,
    required this.userId,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<CartItem2Widget> createState() => _CartItem2WidgetState();
}

class _CartItem2WidgetState extends State<CartItem2Widget> {
  int userIdConnect = 0;
  late User user;

  @override
  void initState() {
    try {
      user = GetIt.instance.get<User>();
      userIdConnect = user.id;
      print(user.name);
      print('user info');
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/pn2.png',
            width: 25.w,
            height: 25.w,
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.libelle,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/ea.png',
                      color: const Color(0xFF1A1A1A),
                      width: 5.w,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      'Pneu été',
                      style: TextStyle(
                        fontFamily: "Cabin",
                        color: const Color(0xFF1A1A1A),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Text(
                      '${widget.prix.toString()} F',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Cabin',
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(width: 30.w),
                    Add3Page(
                      userId: widget.userId,
                      partId: widget.partId,
                      initialQuantity: widget.quantite,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
