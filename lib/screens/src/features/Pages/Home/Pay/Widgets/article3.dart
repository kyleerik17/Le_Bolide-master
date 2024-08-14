import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:Bolide/data/models/api_services.dart';
import 'package:Bolide/data/services/user.dart';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/bouton_ajouter.dart';
import 'package:Bolide/screens/src/features/Pages/commande/pages/details-produit_page.dart';

import 'dart:convert';
import 'package:sizer/sizer.dart';

class Article3Page extends StatefulWidget {
  final int categoryId;
  final int userId;
  const Article3Page({
    Key? key,
    required this.categoryId,
    required this.userId,
  }) : super(key: key);

  @override
  _Article3PageState createState() => _Article3PageState();
}

class _Article3PageState extends State<Article3Page> {
  List<dynamic> _pieces = [];
  bool _isLoading = true;
  late User user;

  @override
  void initState() {
    super.initState();
    try {
      user = GetIt.instance.get<User>();
      print('User ID from GetIt: ${user.id}');
      print('User name from GetIt: ${user.name}');
    } catch (e) {
      print(e);
    }
    _fetchPieces();
  }

  Future<void> _fetchPieces() async {
    final url = '${baseUrl}api/pieces/category/${widget.categoryId}';

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        setState(() {
          _pieces = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load pieces');
      }
    } catch (e) {
      print('Error fetching pieces: $e');
      setState(() {
        _isLoading = false;
        // Ajoutez un état d'erreur ici si nécessaire
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_pieces.isEmpty) {
      return const Center(child: Text('Aucune pièce trouvée'));
    } else {
      return SingleChildScrollView(
        child: Column(
          children: _pieces.map((piece) {
            return _buildArticle(
              imageUrl: '${piece['img']}',
              libelle: piece['libelle'] ?? '',
              iconUrl: 'assets/icons/sun.png',
              description: piece['description'] ?? '',
              price: _formatPrice(piece['price']),
              categoryName: piece['category_name'] ?? '',
              partId: piece['id'] != null
                  ? int.tryParse(piece['id'].toString()) ?? 0
                  : 0,
            );
          }).toList(),
        ),
      );
    }
  }

  String _formatPrice(dynamic price) {
    if (price == null) {
      return '0';
    }

    // Convertir le prix en nombre, en traitant le cas où il s'agit d'une chaîne de caractères
    double priceValue;
    if (price is String) {
      priceValue = double.tryParse(price) ?? 0;
    } else if (price is num) {
      priceValue = price.toDouble();
    } else {
      return '0';
    }

    // Retourner le prix formaté sans décimales
    return priceValue.toStringAsFixed(0);
  }

  Widget _buildArticle({
    required String imageUrl,
    required String libelle,
    required String iconUrl,
    required String description,
    required String price,
    required String categoryName,
    required dynamic partId,
  }) {
    return GestureDetector(
      onTap: () {
        // Naviguer vers DetailsProduitPage en passant l'ID de l'article
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DetailsProduitsPage(
              partId: partId,
              userId: user.id,
              description: description,
              price: price,
              libelle: libelle,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        width: 92.w,
        margin: EdgeInsets.only(bottom: 2.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0.5.h),
        ),
        padding: EdgeInsets.symmetric(vertical: 1.w, horizontal: 2.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 25.w,
              height: 25.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.circular(0.5.h),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    libelle,
                    style: TextStyle(
                      fontSize: 5.w,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Cabin',
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/sun.png',
                        color: const Color(0xFF1A1A1A),
                        width: 4.w,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        categoryName,
                        style: const TextStyle(
                          fontFamily: "Cabin",
                          color: Color(0xFF1A1A1A),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 5.w,
                          fontFamily: "Cabin",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      QuantityWidget(
                        userId: widget.userId,
                        partId: int.parse(partId.toString()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
