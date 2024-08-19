import 'dart:convert';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/bottom.dart';
import 'package:Bolide/screens/src/features/Pages/Search/Pages/find_search_page.dart';
import 'package:Bolide/screens/src/features/Pages/commande/pages/details-produit_page.dart';
import 'package:Bolide/screens/src/features/Pages/commande/widgets/botom.dart';
import 'package:Bolide/screens/src/features/Pages/commande/widgets/bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:Bolide/data/services/user.dart';
import 'package:Bolide/screens/src/features/Pages/Favoris/Widgets/quantity_widget1.dart';
import 'package:Bolide/screens/src/features/Pages/Favoris/Widgets/search2.dart';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/appbar.dart';
import 'package:Bolide/screens/src/features/Pages/Home/Pay/Widgets/add.dart';
import 'package:Bolide/screens/src/features/Pages/Home/Pay/Widgets/add2.dart';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/bouton_ajouter.dart';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/search.dart';
import 'package:sizer/sizer.dart';
import '../../loading modal/pages/pages.dart';
import '../Widgets/bottom.dart';

class FavorisPage extends StatefulWidget {
  final int partId;
  final int userId;

  const FavorisPage({
    Key? key,
    required this.partId,
    required this.userId,
  }) : super(key: key);

  @override
  _FavorisPageState createState() => _FavorisPageState();
}

class _FavorisPageState extends State<FavorisPage> {
  late Future<List<Item>> _futureFavorites;
  late User user;

  @override
  void initState() {
    super.initState();
    try {
      user = GetIt.instance.get<User>();
      print('User ID: ${user.id}');
    } catch (e) {
      print('Error getting user: $e');
    }
    _futureFavorites = fetchFavorites();
  }

  Future<List<Item>> fetchFavorites() async {
    final response = await http.get(
      Uri.parse(
          'https://bolide.armasoft.ci/bolide_services/index.php/api/favorites/user/${user.id}'),
    );

    print('Fetching favorites...');
    print(
        'URL: ${Uri.parse('https://bolide.armasoft.ci/bolide_services/index.php/api/favorites/user/${user.id}')}');

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List favoritesJson = jsonResponse['favorites'];
      print('Favorites JSON: $favoritesJson');
      return favoritesJson.map((data) => Item.fromJson(data)).toList();
    } else {
      print('Failed to load favorites, status code: ${response.statusCode}');
      throw Exception('Failed to load favorites');
    }
  }

  Future<void> _removeFavorite(int partId) async {
    final url =
        'https://bolide.armasoft.ci/bolide_services/index.php/api/favorites/remove/${user.id}/$partId';

    print('Removing favorite...');
    print('URL: $url');

    try {
      final response = await http.delete(Uri.parse(url));

      print(
          'Response status code: ${response.statusCode}'); // Ajout du print du code statut

      if (response.statusCode == 200) {
        print('Article supprimé des favories avec success');
        setState(() {
          _futureFavorites = fetchFavorites();
        });
      } else {
        print('Failed to remove favorite, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error removing favorite: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 3.h),
            AppBarWidget(
              partId: widget.partId,
              userId: widget.userId,
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  Container(
                    width: 92.w,
                    height: 40,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFCED0D4)),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                      ),
                    ),
                    child: TextField(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 300),
                            pageBuilder: (_, __, ___) => FindSearchPage(
                              partId: widget.partId,
                              userId: widget.userId,
                            ),
                            transitionsBuilder: (_, animation, __, child) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0.0, 1.0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Rechercher...',
                        hintStyle: const TextStyle(
                          color: Color(0xFF737373),
                          fontFamily: 'Cabin',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
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
                  ),
                  FutureBuilder<List<Item>>(
                    future: _futureFavorites,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        print('Snapshot error: ${snapshot.error}');
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Text(
                            'Pas de favoris',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "Cabin",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            print('Building item at index: $index');
                            return _buildItem(context, snapshot.data![index]);
                          },
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        partId: widget.partId,
        userId: user.id,
        onTap: (int) {},
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(
              bottom: 5.h), // Ajustez cette valeur selon vos besoins
          width: 20.w,
          height: 20.w,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (_, __, ___) => SearchLoadPage(
                      partId: widget.partId, userId: widget.userId),
                  transitionsBuilder: (_, animation, __, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 1.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13.w),
            ),
            backgroundColor: Colors.black,
            child: Image.asset(
              'assets/icons/home.png',
              width: 10.w,
              height: 10.h,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildItem(BuildContext context, Item item) {
    print('Building item with partId: ${item.partId}');
    return Container(
      padding: EdgeInsets.all(0.w),
      margin: EdgeInsets.symmetric(vertical: 1.h),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 25.w,
            height: 30.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0.5.h),
            ),
            padding: EdgeInsets.all(1.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0.5.h),
              child: Image.network(
                item.imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 300),
                    pageBuilder: (_, __, ___) => DetailsProduitsPage(
                      partId: widget.partId,
                      userId: user.id,
                      price: item.price,
                      description: item.subtitle,
                      categoryName: item.sousCategoryName,
                      iconUrl: item.categoryImg,
                      imageUrl: item.imagePath,
                      sousCategoryName: item.sousCategoryName,
                      sousCategoryImg: item.sousCategoryImg,
                      categoryImg: item.categoryImg,
                      title: item.title,
                      libelle: item.title,
                    ),
                    transitionsBuilder: (_, animation, __, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(height: 0.5.h),
                        Expanded(
                          child: Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: "Cabin",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('Icon tapped for partId: ${item.partId}');
                            if (item.iconPath == 'assets/icons/hrt2.png') {
                              _removeFavorite(item.partId);
                            } else {
                              print('Error: partId is null');
                            }
                          },
                          child: Image.asset(
                            item.iconPath,
                            width: 6.w,
                            height: 6.w,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.5.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          item.sousCategoryImg,
                        ),
                        Text(
                          item.sousCategoryName,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: "Cabin",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${item.price} F',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "Cabin",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Quantity1Widget(
                          userId: widget.userId,
                          partId: item.partId,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  final String title;
  final String imagePath;
  final String subtitle;
  final String subtitleIconPath;
  final String price;
  final int partId;
  String iconPath;
  final String sousCategoryName;
  final String sousCategoryImg;
  final String categoryImg;
  final String categoryName;

  Item({
    required this.title,
    required this.imagePath,
    required this.subtitle,
    required this.subtitleIconPath,
    required this.price,
    required this.partId,
    required this.iconPath,
    required this.sousCategoryName,
    required this.sousCategoryImg,
    required this.categoryImg,
    required this.categoryName, // Ajout du nouvel argument ici
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    print('Parsing JSON: $json');
    return Item(
      title: json['libelle'] ?? '',
      imagePath: json['img'] ?? 'assets/images/pn2.png',
      subtitle: json['description'] ?? '',
      subtitleIconPath:
          (json['category'] != null && json['category']['img'] != null)
              ? json['category']['img']
              : 'assets/icons/default_category.png',
      price: _formatPrice(json['price']?.toString() ?? '0'),
      partId: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      iconPath: 'assets/icons/hrt2.png',
      sousCategoryName: json['sous_category']?['name'] ?? '',
      sousCategoryImg: json['sous_category']?['img'] ?? '',
      categoryImg: json['category']?['img'] ?? '',
      categoryName:
          json['category']?['libelle'] ?? '', // Ajout du nouvel argument ici
    );
  }

  static String _formatPrice(String price) {
    // Convertir le prix en double
    double priceValue = double.tryParse(price) ?? 0.0;

    // Arrondir à l'entier si le prix est un nombre entier
    if (priceValue == priceValue.roundToDouble()) {
      return priceValue.toInt().toString();
    }

    // Sinon, retourner le prix avec un maximum de 2 décimales
    return priceValue.toStringAsFixed(0).replaceAll(RegExp(r'\.00$'), '');
  }

  void toggleIcon() {
    if (iconPath == 'assets/icons/hrt2.png') {
      iconPath = 'assets/icons/oc1.png';
    } else if (iconPath == 'assets/icons/oc1.png') {
      iconPath = 'assets/icons/hrt2.png';
    }
  }
}
