import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:le_bolide/data/services/user.dart';
import 'package:le_bolide/screens/src/features/Pages/Favoris/Widgets/quantity_widget1.dart';
import 'package:le_bolide/screens/src/features/Pages/Favoris/Widgets/search2.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/widgets/appbar.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/Pay/Widgets/add.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/Pay/Widgets/add2.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/widgets/bouton_ajouter.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/widgets/search.dart';
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
            AppBarWidget(partId: widget.partId, userId: widget.userId),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  Search2(partId: widget.partId, userId: widget.userId),
                  FutureBuilder<List<Item>>(
                    future: _futureFavorites,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
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
                          physics: NeverScrollableScrollPhysics(),
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
      bottomNavigationBar: FavorisBottomNavBar(
        onTap: (int) {},
        partId: widget.partId,
        userId: widget.userId,
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
                  transitionDuration: const Duration(milliseconds: 300),
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
    print(
        'Building item with partId: ${item.partId}'); // Impression du partId de l'article
    return Container(
      padding: EdgeInsets.all(0.w),
      margin: EdgeInsets.symmetric(
          vertical: 1.h), // Réduit l'espace vertical entre les éléments
      color: Colors.white, // Fond blanc pour le conteneur principal
      child: Row(
        children: [
          Container(
            width: 25.w, // Ajuste la largeur pour éviter les débordements
            height: 30.w,
            decoration: BoxDecoration(
              color: Colors.white, // Fond blanc pour le conteneur de l'image
              borderRadius: BorderRadius.circular(0.5.h),
            ),
            padding: EdgeInsets.all(1.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0.5.h),
              child: Image.network(
                item.imagePath,
                fit: BoxFit.contain, // Ajuste la couverture de l'image
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white, // Fond blanc pour le conteneur du texte
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: "Cabin",
                            fontWeight: FontWeight.w500,
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
                  SizedBox(
                      height: 0.5
                          .h), // Réduit l'espace entre le titre et la description
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/ar.png',
                        width: 4.w,
                        height: 8.w,
                      ),
                      SizedBox(width: 1.w),
                      Expanded(
                        child: Text(
                          item.subtitle,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: "Cabin",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        item.price,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: "Cabin",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(), // Pour aligner le widget de quantité à droite
                      Quantity1Widget(
                        userId: widget.userId,
                        partId: item.partId, // Utilisation de item.partId
                      ),
                    ],
                  ),
                ],
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
  final int partId; // Assurez-vous que partId est un entier
  String iconPath = 'assets/icons/hrt2.png';

  Item({
    required this.title,
    required this.imagePath,
    required this.subtitle,
    required this.subtitleIconPath,
    required this.price,
    required this.partId,
    required this.iconPath, // Ajoutez iconPath comme argument requis
  });
  factory Item.fromJson(Map<String, dynamic> json) {
    print('Parsing JSON: $json'); // Impression des données JSON
    return Item(
      title: json['libelle'] ?? '',
      imagePath: json['img'], // Concatène la base URL avec le chemin de l'image
      subtitle: json['description'] ?? '',
      subtitleIconPath: '', // Peut être laissé vide si non utilisé
      price: json['price'] ?? '',
      partId: int.tryParse(json['id'].toString()) ??
          0, // Convertir la valeur en entier
      iconPath: 'assets/icons/hrt2.png', // Initialisation de l'icône
    );
  }

  void toggleIcon() {
    if (iconPath == 'assets/icons/hrt2.png') {
      iconPath = 'assets/icons/oc1.png';
    } else if (iconPath == 'assets/icons/oc1.png') {
      iconPath = 'assets/icons/hrt2.png';
    }
  }
}
