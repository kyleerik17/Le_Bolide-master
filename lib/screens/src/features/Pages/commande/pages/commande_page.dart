import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:le_bolide/data/services/user.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/widgets/search.dart';
import 'package:le_bolide/screens/src/features/Pages/commande/widgets/search1.dart';
import 'package:le_bolide/screens/src/features/Pages/registration/pages/pages.dart';
import 'package:sizer/sizer.dart';
import '../../Home/widgets/appbar.dart';
import '../../loading modal/pages/pages.dart';
import '../widgets/bottom.dart';
import '../widgets/commande_container.dart';

class CommandePage extends StatefulWidget {
  final int partId;
  final int userId;
  const CommandePage({Key? key, required this.partId, required this.userId})
      : super(key: key);

  @override
  _CommandePageState createState() => _CommandePageState();
}

class _CommandePageState extends State<CommandePage> {
  String _selectedButton = '';
  List<dynamic> _commandes = [];
  bool _isLoading = true;
  String? _errorMessage;
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
    _fetchCommandes();
  }

  void _fetchCommandes() async {
    print('Fetching commandes...');
    try {
      final response = await http.get(
        Uri.parse(
            'https://bolide.armasoft.ci/bolide_services/index.php/api/orders/user/${user.id}'),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'success' && data['commandes'] is List) {
          setState(() {
            _commandes = data['commandes'];
            _isLoading = false;
          });
        } else {
          setState(() {
            _commandes = [];
            _isLoading = false;
            _errorMessage = 'Aucune commande trouvée.';
          });
        }
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Erreur: ${response.statusCode}\n${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Erreur de connexion: ${e.toString()}';
      });
    }
  }

  void _onButtonPressed(String buttonText) {
    setState(() {
      _selectedButton = buttonText;
    });
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 3.h),
                      AppBarWidget(
                          partId: widget.partId, userId: widget.userId),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Column(
                          children: [
                            Search1(
                                partId: widget.partId, userId: widget.userId),
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
                                      borderRadius:
                                          BorderRadius.circular(0.5.h),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.w),
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
                                    backgroundColor:
                                        _selectedButton == 'En cours'
                                            ? Colors.black
                                            : Colors.white,
                                    side: const BorderSide(color: Colors.grey),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(0.5.h),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    minimumSize: Size(0, 3.8.h),
                                  ),
                                  onPressed: () => _onButtonPressed('En cours'),
                                  child: Text(
                                    'En cours',
                                    style: TextStyle(
                                      color: _selectedButton == 'En cours'
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                Gap(2.w),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        _selectedButton == 'Terminées'
                                            ? Colors.black
                                            : Colors.white,
                                    side: const BorderSide(color: Colors.grey),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(0.5.h),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    minimumSize: Size(0, 3.8.h),
                                  ),
                                  onPressed: () =>
                                      _onButtonPressed('Terminées'),
                                  child: Text(
                                    'Terminées',
                                    style: TextStyle(
                                      color: _selectedButton == 'Terminées'
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Commandes en cours',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'Voir tout',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: "Cabin",
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            for (var commande in _commandes) ...[
                              CommandeContainer(
                                price: '${commande['total_price']} F',
                                description: 'Commande ${commande['id']}',
                                assetIcon: 'assets/icons/rec.png',
                                partId: int.parse(commande['id']),
                                userId: widget.userId,
                              ),
                              SizedBox(
                                  height: 2
                                      .h), // Ajoute un espace vertical entre les commandes
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: ReservBottomNavBar(
          onTap: (int) {}, partId: widget.partId, userId: widget.userId),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 5.h),
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
}
