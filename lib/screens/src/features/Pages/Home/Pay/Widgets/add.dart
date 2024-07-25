import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sizer/sizer.dart';

import '../../../../../../../data/models/api_services.dart';

class AddPage extends StatefulWidget {
  final String partId; // ID de l'article
  final int userId; // ID utilisateur// ID de l'article
  final int quantity;

  const AddPage({
    Key? key,
    required this.userId,
    required this.partId,
    required this.quantity,
  }) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late int _quantity; // Utiliser _quantity au lieu de widget.quantity

  @override
  void initState() {
    super.initState();
    _quantity =
        widget.quantity; // Initialiser _quantity avec la quantité passée
  }

  Future<void> _sendQuantityUpdate(int quantityChange) async {
    const url =
        '${baseUrl}rest-api/api/cart/add'; // URL pour ajouter ou mettre à jour la quantité

    final data = {
      'user_id': widget.userId.toString(),
      'part_id': widget.partId.toString(),
      'quantity':
          quantityChange.toString(), // Utiliser quantityChange comme entier
    };

    try {
      print('Envoi de la requête à $url');
      print('Données envoyées: ${jsonEncode(data)}');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data),
      );

      print('Code de statut reçu: ${response.statusCode}');
      print('Corps de la réponse: ${response.body}');

      if (response.statusCode == 200) {
        print(
            'Quantité mise à jour avec succès: user_id: ${data['user_id']}, part_id: ${data['part_id']}, quantity: ${data['quantity']}');
      } else {
        print(
            'Échec de la mise à jour de la quantité, code de statut: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de l\'envoi de la requête: $e');
    }
  }

  void _incrementQuantity() {
    setState(() {
      if (_quantity < 10) {
        // Limitez la quantité à une valeur raisonnable
        _quantity++;
        _sendQuantityUpdate(_quantity).then((_) {
          print(
              'user_id: ${widget.userId}, part_id: ${widget.partId}, quantity: $_quantity');
        });
      }
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
        _sendQuantityUpdate(_quantity).then((_) {
          print(
              'user_id: ${widget.userId}, part_id: ${widget.partId}, quantity: $_quantity');
        });
      } else {
        // Si la quantité atteint 1, appeler la mise à jour pour retirer l'article du panier
        _quantity--;
        _sendQuantityUpdate(_quantity).then((_) {
          print(
              'user_id: ${widget.userId}, part_id: ${widget.partId}, quantity: $_quantity');
          // Ajoutez ici la logique pour mettre à jour l'interface utilisateur
         
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: 4.2.h,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0.5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(1.5.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                _decrementQuantity();
                print(
                    'user_id: ${widget.userId}, part_id: ${widget.partId}, quantity: $_quantity');
              },
              icon: const Icon(Icons.remove),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
            VerticalDivider(
              color: Colors.grey,
              thickness: 1,
              width: 0.w,
            ),
            SizedBox(
              width: 3.w,
            ),
            Text(
              '$_quantity',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(
              width: 3.w,
            ),
            VerticalDivider(
              color: Colors.grey,
              thickness: 1,
              width: 2.w,
            ),
            IconButton(
              onPressed: () {
                _incrementQuantity();
                print(
                    'user_id: ${widget.userId}, part_id: ${widget.partId}, quantity: $_quantity');
              },
              icon: const Icon(Icons.add),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
          ],
        ),
      ),
    ));
  }
}
