import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:le_bolide/data/models/api_services.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/widgets/bouton_ajouter.dart';
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

  @override
  void initState() {
    super.initState();
    _fetchPieces();
  }

  Future<void> _fetchPieces() async {
    final url = '${baseUrl}api/pieces/category/${widget.categoryId}';

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
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
      return Center(child: CircularProgressIndicator());
    } else if (_pieces.isEmpty) {
      return Center(child: Text('Aucune pièce trouvée'));
    } else {
      return SingleChildScrollView(
        child: Column(
          children: _pieces.map((piece) {
            return _buildArticle(
              imageUrl: '${baseUrl}uploads/${piece['img']}',
              libelle: piece['libelle'] ?? '',
              iconUrl: 'assets/icons/sun.png',
              description: piece['description'] ?? '',
              price: piece['price']?.toString() ?? '0',
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

  Widget _buildArticle({
    required String imageUrl,
    required String libelle,
    required String iconUrl,
    required String description,
    required String price,
    required String categoryName,
    required dynamic partId,
  }) {
    return Container(
      width: 92.w,
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0.5.h),
      ),
      padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20.w,
            height: 25.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.contain,
              ),
              borderRadius: BorderRadius.circular(0.5.h),
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  libelle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
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
                      style: TextStyle(
                        fontFamily: "Cabin",
                        color: const Color(0xFF1A1A1A),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 13.sp,
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
    );
  }
}
