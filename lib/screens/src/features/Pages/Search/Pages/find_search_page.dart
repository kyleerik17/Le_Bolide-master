import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:le_bolide/screens/src/features/Pages/Home/Pay/Widgets/add.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/pages/home_page.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/widgets/bar_search1.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/widgets/bouton_ajouter.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/widgets/detail_produit.dart';
import 'package:le_bolide/screens/src/features/Pages/Search/Pages/find_search_full_page.dart';
import 'package:le_bolide/screens/src/features/Pages/commande/pages/details-produit_page.dart';
import 'package:sizer/sizer.dart';
import 'package:le_bolide/screens/src/features/Pages/Search/Pages/modal2_page.dart';
import 'package:le_bolide/screens/src/features/Pages/Search/Pages/modal_page.dart';
import 'package:le_bolide/data/models/api_services.dart';

class FindSearchPage extends StatefulWidget {
  const FindSearchPage({Key? key}) : super(key: key);

  @override
  _FindSearchPageState createState() => _FindSearchPageState();
}

class _FindSearchPageState extends State<FindSearchPage> {
  String _selectedButton = 'Tout';
  late Future<List<Piece>> _piecesFuture;

  @override
  void initState() {
    super.initState();
    _piecesFuture = _fetchPieces();
  }

  Future<List<Piece>> _fetchPieces() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.11/rest-api/api/pieces'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('Liste des pieces')) {
          final List<dynamic> piecesList = jsonResponse['Liste des pieces'];
          return piecesList.map((piece) => Piece.fromJson(piece)).toList();
        } else {
          throw Exception('Key "Liste des pieces" not found in response');
        }
      } else {
        throw Exception(
            'Failed to load pieces. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching pieces: $error');
    }
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
                      MaterialPageRoute(builder: (context) => const HomePage()),
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
              const SearchBar1Widget(),
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
                          partId: piece.id.toString(), // Convertir l'ID en String
                        );
                      }).toList(),
                    );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
              SizedBox(height: 9.w),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FindSearchPlusPage()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    padding:
                        EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 35.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.w),
                    ),
                  ),
                  child: Text(
                    "Charger plus",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Cabin',
                    ),
                  ),
                ),
              ),
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

class ArticleCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String price;
  final String partId; // ID de l'article

  const ArticleCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.partId, // Ajout de l'ID de l'article
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
                child: const Details1ProduitsPage(),
              );
            },
          ),
        );
      },
      child: Container(
        width: 92.w,
        height: 32.w,
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
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: "Cabin",
                      fontWeight: FontWeight.w400,
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
                        'Pneu été',
                        style: TextStyle(
                          fontFamily: "Cabin",
                          color: const Color(0xFF1A1A1A),
                          fontSize: 13.sp,
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
                      QuantityWidget(userId: '2', partId: partId) // Passer l'ID ici
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