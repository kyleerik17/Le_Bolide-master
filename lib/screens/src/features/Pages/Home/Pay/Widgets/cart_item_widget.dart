import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final String img;
  final String libelle;
  final double prix; // Assurez-vous que le type est double
  final int quantite;
  final String userId;
  final int partId;


  const CartItemWidget({
    Key? key,
    required this.img,
    required this.libelle,
    required this.prix,
    required this.quantite,
    required this.userId,
    required this.partId,
    required void Function(int partId) onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Image.network(img, width: 50, height: 50),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(libelle, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                    'Prix: ${prix.toStringAsFixed(2)} F'), // Affiche avec deux décimales
                Text('Quantité: $quantite'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
