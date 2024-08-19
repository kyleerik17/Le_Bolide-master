import 'dart:convert';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/bottom.dart';
import 'package:Bolide/screens/src/features/Pages/Search/Pages/find_search_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:Bolide/data/services/user.dart';
import 'package:sizer/sizer.dart';
import '../../Home/widgets/appbar.dart';
import '../../loading modal/pages/pages.dart';
import '../widgets/bottom.dart';
import '../widgets/commande_container.dart';

class CommandePage extends StatefulWidget {
  final int partId;
  final int userId;
  const CommandePage({
    Key? key,
    required this.partId,
    required this.userId,
  }) : super(key: key);

  @override
  _CommandePageState createState() => _CommandePageState();
}

const String STATUS_EN_COURS = 'En cours';
const String STATUS_LIVREES = 'Livrés';
const String STATUS_ANNULEES = 'Annulées';

class _CommandePageState extends State<CommandePage> {
  String _selectedButton = 'Tout';
  List<dynamic> _allCommandes = [];
  List<dynamic> _commandes = [];
  bool _isLoading = true;
  String? _errorMessage;
  late User user;

  @override
  void initState() {
    super.initState();
    try {
      user = GetIt.instance.get<User>();
      print(user.name);
      print('user info');
    } catch (e) {
      print(e);
    }
    _fetchCommandes();
  }

  Future<void> _fetchCommandes() async {
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
            _allCommandes = data['commandes'];
            _commandes = _allCommandes;
            _isLoading = false;
          });
          print('All commandes: $_allCommandes');
        } else {
          setState(() {
            _allCommandes = [];
            _commandes = [];
            _isLoading = false;
            _errorMessage = 'Pas de commande';
          });
        }
      } else if (response.statusCode == 404) {
        // Handle 404 error specifically
        setState(() {
          _isLoading = false;
          _errorMessage = 'Pas de commande';
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Erreur serveur: ${response.statusCode}';
        });
      }
    } on http.ClientException {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Pas de connexion Internet';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Erreur de connexion: ${e.toString()}';
      });
    }
  }

  static String _formatPrice(String price) {
    double priceValue = double.tryParse(price) ?? 0.0;
    if (priceValue == priceValue.roundToDouble()) {
      return priceValue.toInt().toString();
    }
    return priceValue.toStringAsFixed(2).replaceAll(RegExp(r'\.00$'), '');
  }

  void _onButtonPressed(String buttonText) {
    setState(() {
      _selectedButton = buttonText;
      print('Selected button: $buttonText');
      if (buttonText == 'Tout') {
        _commandes = _allCommandes;
        print('Filtered commandes (Tout): $_commandes');
      } else {
        String status = '';
        if (buttonText == 'En cours')
          status = STATUS_EN_COURS;
        else if (buttonText == 'Livrées')
          status = STATUS_LIVREES;
        else if (buttonText == 'Annulées') status = STATUS_ANNULEES;

        _commandes = _allCommandes.where((commande) {
          print('Commande status: ${commande['status']}');
          return commande['status'] == status;
        }).toList();
        print('Filtered commandes ($buttonText): $_commandes');
        _printFilteredCommandes(status);
      }
    });
  }

  void _printFilteredCommandes(String status) {
    print('Commandes with status $status:');
    for (var commande in _allCommandes) {
      if (commande['status'] == status) {
        print(commande);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building widget with ${_commandes.length} commandes');
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 3.h),
            AppBarWidget(
              partId: widget.partId,
              userId: widget.userId,
            ),
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
                        hintStyle: TextStyle(
                          color: Color(0xFF737373),
                          fontFamily: 'Cabin',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: SvgPicture.asset(
                            'assets/icons/search.svg',
                            width: 16,
                            height: 16,
                            color: Colors.black,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      style: const TextStyle(
                        color: Color(0xFF737373),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: _selectedButton == 'Tout'
                              ? Color(0xFF0B99FF)
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
                              ? Color(0xFFFF9D0B)
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
                          backgroundColor: _selectedButton == 'Livrées'
                              ? const Color(0xFF09C961)
                              : Colors.white,
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.5.h),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          minimumSize: Size(0, 3.8.h),
                        ),
                        onPressed: () => _onButtonPressed('Livrées'),
                        child: Text(
                          'Livrées',
                          style: TextStyle(
                            color: _selectedButton == 'Livrées'
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                      Gap(2.w),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: _selectedButton == 'Annulées'
                              ? Color(0xFFD93C0A)
                              : Colors.white,
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.5.h),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          minimumSize: Size(0, 3.8.h),
                        ),
                        onPressed: () => _onButtonPressed('Annulées'),
                        child: Text(
                          'Annulées',
                          style: TextStyle(
                            color: _selectedButton == 'Annulées'
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.5.h),
                  SizedBox(height: 2.h),
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else if (_errorMessage != null)
                    Text(_errorMessage!)
                  else if (_commandes.isEmpty)
                    const Text('Aucune commande trouvée')
                  else
                    for (var commande in _commandes) ...[
                      CommandeContainer(
                        price: '${_formatPrice(commande['total_price'])} F',
                        description: '${commande['order_code']}',
                        assetIcon: 'assets/icons/cic.svg',
                        partId: int.parse(commande['id']),
                        userId: widget.userId,
                        status: commande['status'],
                        createdAt: commande['created_at'],
                      ),
                      SizedBox(height: 2.h),
                    ],
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: ReservBottomNavBar(
      //   partId: widget.partId,
      //   userId: widget.userId,
      //   onTap: (int) {},
      // ),
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

  String _getStatusDescription(String status) {
    print('Received status: $status');
    switch (status) {
      case 'E':
        return 'En cours';
      case 'A':
        return 'Annulées';
      case 'L':
        return 'Livrées';
      default:
        return 'Inconnu';
    }
  }
}
