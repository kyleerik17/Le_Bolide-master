import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
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
    try {
      user = GetIt.instance.get<User>();
      print(user.name);
      print('Informations de l\'utilisateur');
    } catch (e) {
      print(e);
    }
    super.initState();
    _piecesFuture = _fetchPieces();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<List<Piece>> _fetchPieces({String? searchTerm}) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${baseUrl}api/pieces/search?part_name=${searchTerm ?? ""}&category_id='),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('pieces')) {
          final List<dynamic> piecesList = jsonResponse['pieces'];
          return piecesList.map((piece) => Piece.fromJson(piece)).toList();
        } else {
          throw Exception('Key "pieces" not found in response');
        }
      } else {
        throw Exception(
            'Failed to load pieces. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching pieces: $error');
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _piecesFuture = _fetchPieces(searchTerm: query);
      });
    });
  }

  void _onButtonPressed(String buttonName) {
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data!.map((piece) {
                        return ArticleCard(
                          imageUrl: piece.img,
                          title: piece.libelle,
                          description: piece.description,
                          price: piece.price,
                          partId: int.parse(piece.id), // Convert String to int
                          userId: widget.userId,
                          libelle: piece.libelle,
                        );
                      }).toList(),
                    );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
              SizedBox(height: 9.w),
              // Center(
              //   child: TextButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => FindSearchPlusPage(
              //                 partId: widget.partId, userId: widget.userId)),
              //       );
              //     },
              //     style: TextButton.styleFrom(
              //       backgroundColor: const Color(0xFF1A1A1A),
              //       padding:
              //           EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 35.w),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(1.w),
              //       ),
              //     ),
              //     child: Text(
              //       "Charger plus",
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 12.sp,
              //         fontWeight: FontWeight.w500,
              //         fontFamily: 'Cabin',
              //       ),
              //     ),
              //   ),
              // ),
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
              child: Image.asset(
                'assets/icons/fltr.png',
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
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(1.h),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: 'Rechercher...',
        hintStyle: TextStyle(
          color: const Color(0xFF737373),
          fontFamily: 'Poppins',
          fontSize: 10.sp,
        ),
        prefixIcon: ImageIcon(
          const AssetImage('assets/icons/search.png'),
          size: 5.w,
          color: Colors.black,
        ),
      ),
    );
  }
}

class Piece {
  final String id;
  final String img;
  final String libelle;
  final String description;
  final String price;
  final String categoryId;
  final String vehicleId;
  final String createdAt;
  final String updatedAt;

  Piece({
    required this.id,
    required this.img,
    required this.libelle,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.vehicleId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Piece.fromJson(Map<String, dynamic> json) {
    return Piece(
      id: json['id'],
      img: json['img'],
      libelle: json['libelle'],
      description: json['description'],
      price: json['price'],
      categoryId: json['category_id'],
      vehicleId: json['vehicle_id'],
      createdAt: json['created_at'],
      updatedAt: json['update_at'] ?? '',
    );
  }
}

class ArticleCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String price;
  final String libelle;

  final int partId;
  final int userId;

  const ArticleCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.partId,
    required this.userId,
    required this.libelle,
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
                ),
              );
            },
          ),
        );
      },
      child: Container(
        width: 92.w,
        height: 33.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0.5.h),
        ),
        child: Row(
          children: [
            Container(
              width: 20.w,
              height: 25.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(0.5.h),
              ),
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.w),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: "Cabin",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/sun.png',
                        color: const Color(0xFF1A1A1A),
                        width: 4.w,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        description,
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
                          fontSize: 13.sp,
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
