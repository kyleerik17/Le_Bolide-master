import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:le_bolide/data/models/api_services.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/widgets/detail_produit.dart';
import 'dart:convert';
import 'package:sizer/sizer.dart';

class AddPage extends StatefulWidget {
  final int userId;
  final int partId;
  final int quantity; // Ajout du paramètre quantity

  const AddPage({
    Key? key,
    required this.userId,
    required this.partId,
    required this.quantity, required int initialQuantity,
  }) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  bool _showQuantityControls = false;
  late int _quantity; // Utiliser late pour l'initialiser dans initState

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity; // Initialiser _quantity avec la valeur reçue
  }

  Future<void> _sendQuantityUpdate() async {
    final url = '${baseUrl}api/cart/add';

    final data = {
      'user_id': widget.userId.toString(),
      'part_id': widget.partId.toString(),
      'quantity': _quantity.toString(),
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
      if (_quantity < 2) {
        _quantity++;
      }
    });
    _sendQuantityUpdate().then((_) {
      print(
          'user_id: ${widget.userId}, part_id: ${widget.partId}, quantity: $_quantity');
      if (_quantity >= 2) {
        _navigateToPay1Page();
      }
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      } else {
        _quantity = 1; // Assurer que la quantité ne tombe pas en dessous de 1
        _showQuantityControls = false; // Cacher les contrôles et montrer le bouton "Ajouter"
      }
    });
    _sendQuantityUpdate().then((_) {
      print(
          'user_id: ${widget.userId}, part_id: ${widget.partId}, quantity: $_quantity');
    });
  }

  void _navigateToPay1Page() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            Details1ProduitsPage(
          partId: widget.partId,
          userId: widget.userId, // Utiliser widget.userId ici
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  void _toggleQuantityControls() {
    setState(() {
      _showQuantityControls = !_showQuantityControls;
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
                onPressed: _decrementQuantity,
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
                onPressed: _incrementQuantity,
                icon: const Icon(Icons.add),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
