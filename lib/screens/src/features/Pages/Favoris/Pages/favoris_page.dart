import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:le_bolide/data/services/user.dart';
import 'package:le_bolide/screens/src/features/Pages/Favoris/Widgets/quantity_widget_fav.dart';
import 'package:le_bolide/screens/src/features/Pages/Favoris/Widgets/search2.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/widgets/search.dart';
import 'package:sizer/sizer.dart';
import '../../Home/widgets/appbar.dart';
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
    try {
      user = GetIt.instance.get<User>();
      print(user.id);
      print('user info');
    } catch (e) {
      print(e);
    }
    super.initState();
    _futureFavorites = fetchFavorites();
  }

  Future<List<Item>> fetchFavorites() async {
    final response = await http.get(
      Uri.parse(
          'https://bolide.armasoft.ci/bolide_services/index.php/api/favorites/user/${user.id}'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List favoritesJson = jsonResponse['favorites'];
      return favoritesJson.map((data) => Item.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load favorites');
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
              padding: EdgeInsets.all(2.w),
              child: Column(
                children: [
                  Search2(partId: widget.partId, userId: widget.userId),
                  FutureBuilder<List<Item>>(
                    future: _futureFavorites,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Text(
                            'No favorites found',
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
    return Row(
      children: [
        Container(
          width: 94.w,
          height: 30.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0.5.h),
          ),
          padding: EdgeInsets.all(1.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(item.imagePath),
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
                      item.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "Cabin",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Image.network(
                          item.subtitleIconPath,
                          width: 6.w,
                          height: 6.w,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          item.subtitle,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: "Cabin",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          item.price,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: "Cabin",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        QuantityWidgetFav(
                          userId: widget.userId,
                          partId: widget.partId,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        item.toggleIcon();
                      });
                    },
                    child: Image.asset(
                      item.iconPath,
                      width: 6.w,
                      height: 10.w,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Item {
  final String title;
  final String imagePath;
  final String subtitle;
  final String subtitleIconPath;
  final String price;
  String iconPath = 'assets/icons/hrt2.png';

  Item({
    required this.title,
    required this.imagePath,
    required this.subtitle,
    required this.subtitleIconPath,
    required this.price,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      title: json['libelle'] ?? '', // Updated to match the new key
      imagePath: json['img'] ?? '', // Updated to match the new key
      subtitle: json['description'] ?? '', // Updated to match the new key
      subtitleIconPath:
          '', // No equivalent in the new response, can be left as empty string
      price: json['price'] ?? '', // Updated to match the new key
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
