import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
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

  @override
  void initState() {
    super.initState();
    _fetchCommandes();
  }

  void _fetchCommandes() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://bolide.armasoft.ci/bolide_services/index.php/api/orders/24'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _commandes = data['commandes'];
          _isLoading = false;
        });
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
        print('Response body: ${response.body}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle any errors that occur during the fetch
      print('Error fetching commandes: $e');
      setState(() {
        _isLoading = false;
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
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3.h),
                  AppBarWidget(partId: widget.partId, userId: widget.userId),
                  Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 4.w),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(1.h),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Rechercher',
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
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
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
                                backgroundColor: _selectedButton == 'En cours'
                                    ? Colors.black
                                    : Colors.white,
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.5.h),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
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
                                backgroundColor: _selectedButton == 'Terminées'
                                    ? Colors.black
                                    : Colors.white,
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.5.h),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                minimumSize: Size(0, 3.8.h),
                              ),
                              onPressed: () => _onButtonPressed('Terminées'),
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
                              partId: widget.partId,
                              userId: widget.userId),
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
          margin: EdgeInsets.only(bottom: 7.h),
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
