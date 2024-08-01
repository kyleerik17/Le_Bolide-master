import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:le_bolide/data/models/api_services.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/Pay/Widgets/article3.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/pages/Categories/widgets/search_pneu.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/pages/home_page.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../data/services/user.dart';

class Categorie extends StatefulWidget {
  final int partId;
  final int userId;
  const Categorie({Key? key, required this.partId, required this.userId})
      : super(key: key);

  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  late Future<List<Map<String, dynamic>>> categories;
  late User user;
  @override
  void initState() {
    try {
      user = GetIt.instance.get<User>();
      print(user.id);
      print('user info');
    } catch (e) {
      print(e);
    }
    super.initState();
    categories = fetchCategories();
  }

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final response = await http.get(Uri.parse('${baseUrl}api/categorie/parts'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data
          .map<Map<String, dynamic>>((category) => {
                'icon': category['logo'],
                'label': category['libelle'],
                'id': category['id'],
              })
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  void navigateToCategory(String categoryId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDetailPage(
            categoryId: categoryId,
            partId: widget.partId,
            userId: widget.userId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: categories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Aucune catégorie trouvée'));
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: snapshot.data!.map((category) {
                return Padding(
                  padding: EdgeInsets.only(
                      right: 2.w), // Espacement entre les catégories
                  child: _buildCategorie(
                    icon: category['icon'],
                    label: category['label'],
                    onTap: () => navigateToCategory(category['id']),
                  ),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }

  Widget _buildCategorie({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 25.w,
            height: 25.w,
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Center(
              child: Image.network(
                icon,
                width: 12.w,
                height: 12.w,
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Cabin',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CategoryDetailPage extends StatefulWidget {
  final int partId;
  final int userId;
  final String categoryId;

  const CategoryDetailPage({
    Key? key,
    required this.categoryId,
    required this.partId,
    required this.userId,
  }) : super(key: key);

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  late Future<Map<String, dynamic>> categoryDetail;
  String _selectedButton = '';
  late User user;
  @override
  void initState() {
    try {
      user = GetIt.instance.get<User>();
      print(user.name);
      print('user info');
    } catch (e) {
      print(e);
    }
    super.initState();
    categoryDetail = fetchCategoryDetail(widget.categoryId);
  }

  Future<Map<String, dynamic>> fetchCategoryDetail(String categoryId) async {
    final response =
        await http.get(Uri.parse('${baseUrl}api/pieces/category/$categoryId'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)[0];
    } else {
      throw Exception('echec de chargement');
    }
  }

  void _onButtonPressed(String buttonText) {
    setState(() {
      _selectedButton = buttonText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        HomePage(partId: widget.partId, userId: widget.userId),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(-1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.ease;

                      final tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      final offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Image.asset(
                'assets/icons/gc.png',
                width: 40,
                height: 40,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Détails de la catégorie',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: FutureBuilder<Map<String, dynamic>>(
            future: categoryDetail,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erreur: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('Aucune donnée trouvée'));
              } else {
                return Container(
                  color: const Color(0xFFF7F8F9),
                  padding: EdgeInsets.all(4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SearchPneu(),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: _selectedButton == 'Tout'
                                  ? Colors.black
                                  : Colors.white,
                              side: const BorderSide(color: Colors.grey),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.5.h),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              minimumSize: Size(0, 3.8.h),
                            ),
                            onPressed: () => _onButtonPressed('Tout'),
                            child: Text(
                              'Tout',
                              style: TextStyle(
                                color: _selectedButton == 'Tout'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                          Gap(2.w),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(color: Colors.grey),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.5.h),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              minimumSize: Size(0, 3.8.h),
                            ),
                            onPressed: () => _onButtonPressed('Filtres'),
                            child: Row(
                              children: [
                                const Text(
                                  'Filtres',
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(width: 1.w),
                                Image.asset(
                                  'assets/icons/fltr.png',
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Gap(2.w),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(color: Colors.grey),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.5.h),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              minimumSize: Size(0, 3.8.h),
                            ),
                            onPressed: () => _onButtonPressed('Trier par'),
                            child: Row(
                              children: [
                                const Text(
                                  'Trier par',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 1.w),
                                Image.asset(
                                  'assets/icons/fltr.png',
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Article3Page(
                          categoryId: int.parse(widget.categoryId),
                          userId: widget.userId),
                    ],
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
