import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Bolide/screens/src/features/Pages/Home/widgets/categorie.dart';
import 'package:sizer/sizer.dart';
import '../../home_page.dart';

class CategoriesPage extends StatefulWidget {
  final int partId;
  final int userId;
  final String categoryName;

  const CategoriesPage({
    super.key,
    required this.partId,
    required this.userId,
    required this.categoryName,
  });

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late Future<List<Map<String, dynamic>>> categories;

  @override
  void initState() {
    super.initState();
    categories = fetchCategories();
  }

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final response = await http.get(Uri.parse(
        'https://bolide.armasoft.ci/bolide_services/index.php/api/categorie'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map<Map<String, dynamic>>((category) {
        final String logo = category['logo'];
        // Vérifier si l'URL du logo commence par 'http' ou 'https'
        final validIconUrl = logo.startsWith('http://') ||
                logo.startsWith('https://')
            ? logo
            : 'https://default.image.url/default.png'; // URL de remplacement si nécessaire

        return {
          'icon': validIconUrl,
          'label': category['libelle'],
          'id': category['id'],
        };
      }).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  void navigateToCategory(String categoryId, String categoryName) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CategoryDetailPage(
          categoryId: categoryId,
          partId: widget.partId,
          userId: widget.userId,
          categoryName: categoryName,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    HomePage(
                  partId: widget.partId,
                  userId: widget.userId,
                ),
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
          'Catégories',
          style: TextStyle(
            color: Colors.black,
            fontSize: 6.w,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFFCFCFC),
        padding: EdgeInsets.all(4.w),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: categories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erreur: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Aucune catégorie trouvée'));
            } else {
              return GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                children: snapshot.data!.map((category) {
                  return GestureDetector(
                    onTap: () =>
                        navigateToCategory(category['id'], category['label']),
                    child: CategoryItem(
                      icon: category['icon'],
                      label: category['label'],
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String icon;
  final String label;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 20.w,
          height: 20.w,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Image.network(
              icon,
              width: 12.w,
              height: 12.w,
              fit: BoxFit.contain,
              // errorBuilder: (context, error, stackTrace) {
              //   // Afficher une image par défaut en cas d'erreur de chargement
              //   return Image.network(
              //     'https://default.image.url/default.png',
              //     width: 12.w,
              //     height: 12.w,
              //     fit: BoxFit.contain,
              //   );
              // },
            ),
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
