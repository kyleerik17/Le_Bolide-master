import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:Bolide/data/services/user.dart';
import 'package:Bolide/screens/src/features/Pages/Home/pages/home_page.dart';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/bar_search1.dart';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/bouton_ajouter.dart';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/detail_produit.dart';
import 'package:Bolide/screens/src/features/Pages/Search/Pages/find_search_full_page.dart';
import 'package:Bolide/screens/src/features/Pages/commande/pages/details-produit_page.dart';
import 'package:sizer/sizer.dart';
import 'package:Bolide/screens/src/features/Pages/Search/Pages/modal2_page.dart';
import 'package:Bolide/screens/src/features/Pages/Search/Pages/modal_page.dart';
import 'package:Bolide/data/models/api_services.dart';

class FindSearchPage extends StatefulWidget {
  final int partId;
  final int userId;

  const FindSearchPage({Key? key, required this.partId, required this.userId})
      : super(key: key);

  @override
  _FindSearchPageState createState() => _FindSearchPageState();
}

class _FindSearchPageState extends State<FindSearchPage> {
  String _selectedButton = 'Tout';
  late Future<List<Piece>> _piecesFuture;
  late User user;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    print("Initialisation de FindSearchPage");
    try {
      user = GetIt.instance.get<User>();
      print('Informations de l\'utilisateur: ${user.name}');
    } catch (e) {
      print('Erreur lors de la récupération de l\'utilisateur: $e');
    }
    _piecesFuture = _fetchPieces();
  }

  @override
  void dispose() {
    print("Disposition de FindSearchPage");
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<List<Piece>> _fetchPieces({String? searchTerm}) async {
    print("Début de _fetchPieces avec searchTerm: $searchTerm");
    try {
      final url =
          '${baseUrl}api/pieces/search?part_name=${searchTerm ?? ""}&category_id=';
      print("URL de la requête: $url");

      final response = await http.get(Uri.parse(url));

      print("Code de statut de la réponse: ${response.statusCode}");
      print("Corps de la réponse brute: ${response.body}");

      if (response.statusCode == 200) {
        print("Réponse 200 OK, décodage du JSON...");
        final jsonResponse = json.decode(response.body);

        print("JSON décodé: $jsonResponse");

        if (jsonResponse == null) {
          print("La réponse JSON est null");
          throw Exception('La réponse de l\'API est null');
        }

        if (jsonResponse is! Map<String, dynamic>) {
          print("La réponse JSON n'est pas un Map<String, dynamic>");
          throw Exception('Format de réponse inattendu');
        }

        if (!jsonResponse.containsKey('pieces')) {
          print("La clé 'pieces' est manquante dans la réponse JSON");
          print("Clés disponibles: ${jsonResponse.keys}");
          throw Exception('Clé "pieces" non trouvée dans la réponse');
        }

        final List<dynamic> piecesList = jsonResponse['pieces'];
        print("Nombre de pièces trouvées: ${piecesList.length}");

        return piecesList.map((piece) {
          print("Conversion d'une pièce: $piece");
          return Piece.fromJson(piece);
        }).toList();
      } else {
        print("Réponse non-200: ${response.statusCode}");
        throw Exception(
            'Échec du chargement des pièces. Code de statut : ${response.statusCode}');
      }
    } catch (error) {
      print("Erreur attrapée dans _fetchPieces: $error");
      if (error is FormatException) {
        print("Erreur de format JSON: ${error.message}");
      }
      throw Exception('Pas de Connexion. Verifiez votre connexion internet. ');
    }
  }

  void _onSearchChanged(String query) {
    print("Recherche changée: $query");
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _piecesFuture = _fetchPieces(searchTerm: query);
      });
    });
  }

  void _onButtonPressed(String buttonName) {
    print("Bouton pressé: $buttonName");
    setState(() {
      _selectedButton = buttonName;
    });

    Future.microtask(() {
      if (buttonName == 'Filtres') {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return const ModalPage();
          },
        );
      } else if (buttonName == 'Trier par') {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return const Modal2Page();
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Construction du widget FindSearchPage");
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 6.w),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                              partId: widget.partId, userId: widget.userId)),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFEBEBEB),
                      ),
                      padding: EdgeInsets.all(0.w),
                      child: Image.asset(
                        'assets/icons/close.png',
                        width: 12.w,
                        height: 12.w,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.w),
              SearchBar1Widget(
                controller: _searchController,
                onChanged: _onSearchChanged,
              ),
              SizedBox(height: 2.w),
              Row(
                children: [
                  _buildFilterButton('Tout', _selectedButton == 'Tout'),
                  Gap(2.w),
                  _buildFilterButton('Filtres', false, true),
                  Gap(2.w),
                  _buildFilterButton('Trier par', false, true),
                ],
              ),
              SizedBox(height: 2.w),
              FutureBuilder<List<Piece>>(
                future: _piecesFuture,
                builder: (context, snapshot) {
                  print("État de la connexion: ${snapshot.connectionState}");
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print("Erreur dans FutureBuilder: ${snapshot.error}");
                    return Center(child: Text('Erreur: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final pieces = snapshot.data!;
                    print("Nombre de pièces reçues: ${pieces.length}");
                    if (pieces.isEmpty) {
                      return const Center(child: Text('Aucune pièce trouvée'));
                    }
                    return Column(
                      children: pieces.map((piece) {
                        print("Affichage de la pièce: ${piece.libelle}");
                        // Exemple lors de la création d'un ArticleCard
                        return ArticleCard(
                          imageUrl: piece.img,
                          title: piece.libelle,
                          description: piece.description,
                          price: _formatPrice(piece.price),
                          partId: int.parse(piece.id),
                          userId: widget.userId,
                          libelle: piece.libelle,
                          categoryName:
                              piece.category.name, // Nom de la catégorie
                          sousCategoryName: piece
                              .sousCategory.name, // Nom de la sous-catégorie
                          categoryImg:
                              piece.category.img, // Image de la catégorie
                          sousCategoryImg: piece
                              .sousCategory.img, // Image de la sous-catégorie
                        );
                      }).toList(),
                    );
                  } else {
                    print("Aucune donnée disponible");
                    return const Center(
                        child: Text('Aucune donnée disponible'));
                  }
                },
              ),
              SizedBox(height: 9.w),
            ],
          ),
        ),
      ),
    );
  }

  TextButton _buildFilterButton(String label, bool isSelected,
      [bool isIcon = false]) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Colors.black : Colors.white,
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.5.h),
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        minimumSize: Size(0, 3.8.h),
      ),
      onPressed: () => _onButtonPressed(label),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
          if (isIcon)
            Padding(
              padding: EdgeInsets.only(left: 1.w),
              child: SvgPicture.asset(
                'assets/icons/filter.svg',
                width: 16,
                height: 16,
                color: Colors.black,
              ),
            ),
        ],
      ),
    );
  }
}

class SearchBar1Widget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchBar1Widget({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92.w,
      height: 40,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFCED0D4)),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
        ),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          hintText: 'Rechercher...',
          hintStyle: TextStyle(
            color: const Color(0xFF737373),
            fontFamily: 'Cabin',
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              width: 16,
              height: 16,
              color: Colors.black,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
        ),
        style: const TextStyle(
          color: Color(0xFF737373),
        ),
      ),
    );
  }
}

String _formatPrice(dynamic price) {
  if (price == null) {
    return '0';
  }

  double priceValue;
  if (price is String) {
    priceValue = double.tryParse(price) ?? 0;
  } else if (price is num) {
    priceValue = price.toDouble();
  } else {
    return '0';
  }

  return priceValue.toStringAsFixed(0);
}

class Piece {
  final String id;
  final String img;
  final String libelle;
  final String description;
  final String price;
  final String createdAt;
  final String? updatedAt;
  final Category category;
  final SubCategory sousCategory;

  Piece({
    required this.id,
    required this.img,
    required this.libelle,
    required this.description,
    required this.price,
    required this.createdAt,
    this.updatedAt,
    required this.category,
    required this.sousCategory,
  });

  factory Piece.fromJson(Map<String, dynamic> json) {
    return Piece(
      id: json['id']?.toString() ?? '',
      img: json['img'] ?? '',
      libelle: json['libelle'] ?? '',
      description: json['description'] ?? '',
      price: json['price']?.toString() ?? '0',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['update_at'],
      category: Category.fromJson(json['category'] ?? {}),
      sousCategory: SubCategory.fromJson(json['sous_category'] ?? {}),
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
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      img: json['img'] ?? '',
    );
  }
}

class SubCategory {
  final String id;
  final String name;
  final String img;

  SubCategory({
    required this.id,
    required this.name,
    required this.img,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      img: json['img'] ?? '',
    );
  }
}

class ArticleCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String categoryName;
  final String sousCategoryName; // Remplace 'Pneu été' par cette valeur
  final String price;
  final String libelle;
  final int partId;
  final String description;
  final int userId;
  final String categoryImg;
  final String sousCategoryImg;

  const ArticleCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.categoryName,
    required this.sousCategoryName, // Utilise cette valeur
    required this.price,
    required this.partId,
    required this.userId,
    required this.libelle,
    required this.categoryImg,
    required this.sousCategoryImg,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween = Tween(begin: begin, end: end);
              var curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: curve,
              );
              var offsetAnimation = tween.animate(curvedAnimation);

              return SlideTransition(
                position: offsetAnimation,
                child: DetailsProduitsPage(
                  partId: partId,
                  userId: userId,
                  price: price,
                  libelle: libelle,
                  description: description,
                  categoryName: categoryName,
                  categoryImg: categoryImg,
                  sousCategoryName: sousCategoryName, // Utilise cette valeur
                  sousCategoryImg: sousCategoryImg,
                  imageUrl: imageUrl,
                  iconUrl: '', title: title,
                ),
              );
            },
          ),
        );
      },
      child: Container(
        width: 90.w,
        height: 32.w,
        margin: EdgeInsets.only(bottom: 0.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0.5.h),
        ),
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 25.w,
              height: 29.w,
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
                  SizedBox(height: 1.w),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: "Cabin",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        categoryImg.isNotEmpty
                            ? categoryImg
                            : 'assets/icons/sun.png',
                        width: 4.w,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        sousCategoryName.isNotEmpty
                            ? sousCategoryName // Affiche le nom de la sous-catégorie
                            : 'Pneu été',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "Cabin",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$price F',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: "Cabin",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      QuantityWidget(
                        userId: userId,
                        partId: partId,
                      )
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
