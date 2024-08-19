import 'package:Bolide/data/services/user.dart';
import 'package:Bolide/screens/src/features/Pages/Favoris/Widgets/quantity_widget1.dart';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/bouton2add.dart';
import 'package:Bolide/screens/src/features/Pages/Home/widgets/bouton_ajouter.dart';
import 'package:Bolide/screens/src/features/Pages/registration/pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContaiRizon extends StatefulWidget {
  final int userId;
  final int partId;
  const ContaiRizon({Key? key, required this.userId, required this.partId})
      : super(key: key);

  @override
  _ContaiRizonState createState() => _ContaiRizonState();
}

class _ContaiRizonState extends State<ContaiRizon> {
  List<dynamic> _pieces = [];
  late User user;

  @override
  void initState() {
    super.initState();

    try {
      user = GetIt.instance.get<User>();
      print('User Name: ${user.name}');
      print('User ID: ${user.id}');
    } catch (e) {
      print('Error fetching user: $e');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              RegistrationPage(userId: widget.userId, partId: widget.partId),
        ),
      );
    }

    _fetchPieces(widget.partId, user.id);
  }

  Future<void> _fetchPieces(partId, userId) async {
    final response = await http.get(Uri.parse(
        'https://bolide.armasoft.ci/bolide_services/index.php/api/pieces'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _pieces = data['Liste des pieces'];
      });
    } else {
      print('Failed to load pieces');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _pieces.isNotEmpty
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: _pieces.map((piece) {
                return Container(
                  width: 45.w,
                  height: 69.w,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(2.w),
                          child: Image.network(
                            piece['img'],
                            width: 25.w,
                            height: 25.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.w),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Text(
                          piece['libelle'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Cabin',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.w),
                      Row(
                        children: [
                          SizedBox(width: 2.w),
                          Image.network(
                            piece['sous_category']['img'],
                            color: const Color(0xFF1A1A1A),
                            width: 4.w,
                          ),
                          Text(
                            piece['sous_category']['name'],
                            style: TextStyle(
                              fontFamily: "Cabin",
                              color: const Color(0xFF1A1A1A),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.w),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Text(
                          '${piece['price']} F',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.w),
                      QuantityWidget1(partId: widget.partId, userId: user.id),
                    ],
                  ),
                );
              }).toList(),
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
