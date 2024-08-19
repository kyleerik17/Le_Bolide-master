import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

// Step 1: Define Models

class Piece {
  final String id;
  final String img;
  final String libelle;
  final String description;
  final String price;
  final String createdAt;
  final String? updatedAt;
  final Category category;
  final Fabriquant fabriquant;
  final SousCategory sousCategory;

  Piece({
    required this.id,
    required this.img,
    required this.libelle,
    required this.description,
    required this.price,
    required this.createdAt,
    this.updatedAt,
    required this.category,
    required this.fabriquant,
    required this.sousCategory,
  });

  factory Piece.fromJson(Map<String, dynamic> json) {
    return Piece(
      id: json['id'],
      img: json['img'],
      libelle: json['libelle'],
      description: json['description'],
      price: json['price'],
      createdAt: json['created_at'],
      updatedAt: json['update_at'],
      category: Category.fromJson(json['category']),
      fabriquant: Fabriquant.fromJson(json['fabriquant']),
      sousCategory: SousCategory.fromJson(json['sous_category']),
    );
  }
}

class Category {
  final String id;
  final String name;
  final String img;

  Category({
    required this.id,
    required this.name,
    required this.img,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      img: json['img'],
    );
  }
}

class Fabriquant {
  final String id;
  final String name;

  Fabriquant({
    required this.id,
    required this.name,
  });

  factory Fabriquant.fromJson(Map<String, dynamic> json) {
    return Fabriquant(
      id: json['id'],
      name: json['name'],
    );
  }
}

class SousCategory {
  final String id;
  final String name;
  final String img;

  SousCategory({
    required this.id,
    required this.name,
    required this.img,
  });

  factory SousCategory.fromJson(Map<String, dynamic> json) {
    return SousCategory(
      id: json['id'],
      name: json['name'],
      img: json['img'],
    );
  }
}

class PiecesResponse {
  final List<Piece> pieces;

  PiecesResponse({
    required this.pieces,
  });

  factory PiecesResponse.fromJson(Map<String, dynamic> json) {
    var list = json['Liste des pieces'] as List;
    List<Piece> piecesList = list.map((i) => Piece.fromJson(i)).toList();

    return PiecesResponse(
      pieces: piecesList,
    );
  }
}

// Step 2: Define API Service

class ApiService {
  final String apiUrl =
      "https://bolide.armasoft.ci/bolide_services/index.php/api/pieces";

  Future<PiecesResponse> fetchPieces() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return PiecesResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load pieces');
    }
  }
}

// Step 3: Build the Page

class SelectArtiPage extends StatefulWidget {
  @override
  _SelectArtiPageState createState() => _SelectArtiPageState();
}

class _SelectArtiPageState extends State<SelectArtiPage> {
  late Future<PiecesResponse> futurePieces;

  @override
  void initState() {
    super.initState();
    futurePieces = ApiService().fetchPieces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select an Article'),
      ),
      body: FutureBuilder<PiecesResponse>(
        future: futurePieces,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.pieces.isEmpty) {
            return Center(child: Text('No data found.'));
          } else {
            return Padding(
              padding: EdgeInsets.all(4.w),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of items per row
                  crossAxisSpacing: 4.w,
                  mainAxisSpacing: 4.w,
                  childAspectRatio: 0.6, // Adjust the height/width ratio
                ),
                itemCount: snapshot.data!.pieces.length,
                itemBuilder: (context, index) {
                  return _buildItemCard(snapshot.data!.pieces[index]);
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildItemCard(Piece piece) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(2.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Image.network(
                  piece.img,
                  fit: BoxFit.contain,
                  height: 15.h,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              piece.libelle,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              '🌞 ${piece.sousCategory.name}',
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              '${piece.price} F',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
              ),
              child: Center(
                child: Text(
                  'Ajouter',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
