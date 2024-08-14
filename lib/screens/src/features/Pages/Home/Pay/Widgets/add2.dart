import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:Bolide/data/models/api_services.dart';
import 'package:Bolide/data/services/user.dart';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/detail_produit.dart';
import 'package:sizer/sizer.dart';

class Add2Page extends StatefulWidget {
  final int userId;
  final int partId;

  const Add2Page({
    Key? key,
    required this.userId,
    required this.partId,
  }) : super(key: key);

  @override
  _Add2PageState createState() => _Add2PageState();
}

class _Add2PageState extends State<Add2Page> {
  bool _showQuantityControls = false;
  int _quantity = 0; // Initialisez la quantité ici
  late User user;

  @override
  void initState() {
    super.initState();
    try {
      user = GetIt.instance.get<User>();
      print('ID utilisateur de GetIt: ${user.id}');
      print('Nom utilisateur de GetIt: ${user.name}');
    } catch (e) {
      print('Erreur lors de la récupération de l\'utilisateur: $e');
    }
  }

  Future<void> _sendQuantityUpdate() async {
    final url = '${baseUrl}api/cart/add/${user.id}';

    final data = {
      'user_id': user.id.toString(),
      'part_id': widget.partId.toString(),
      'quantity': _quantity.toString(),
    };

    print('Données envoyées: ${jsonEncode(data)}');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data),
      );

      print('Code de statut: ${response.statusCode}');
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

  Future<void> _removeItemFromCart() async {
    final url = '${baseUrl}api/cart/remove/${user.id}/${widget.partId}';

    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody['status'] == 'success') {
          print('Article supprimé avec succès');
        } else {
          print(
              'Échec de la suppression de l\'article: ${responseBody['message']}');
        }
      } else {
        print('Erreur HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de la suppression de l\'article: $e');
    }
  }

  void _incrementQuantity() {
    setState(() {
      if (_quantity < 8) {
        _quantity++;
      }
    });
    _sendQuantityUpdate().then((_) {
      print(
          'user_id: ${user.id}, part_id: ${widget.partId}, quantity: $_quantity');
      if (_quantity >= 8) {
        _navigateToPay1Page();
      }
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
        _sendQuantityUpdate().then((_) {
          print(
              'user_id: ${user.id}, part_id: ${widget.partId}, quantity: $_quantity');
        });
      } else {
        _removeItemFromCart().then((_) {
          print(
              'user_id: ${user.id}, part_id: ${widget.partId}, quantity: $_quantity');
        });
      }
    });
  }

  void _navigateToPay1Page() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            Details1ProduitsPage(
          partId: widget.partId,
          userId: widget.userId,
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
