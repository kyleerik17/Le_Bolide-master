import 'package:flutter/material.dart';
import 'package:Bolide/screens/src/features/Pages/loading%20modal/pages/resultat_search2_page.dart';
import 'package:Bolide/screens/src/features/Pages/loading%20modal/pages/resultat_search_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import '../../Home/pages/pages.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchLoadPage extends StatefulWidget {
  final int partId;
  final int userId;
  const SearchLoadPage({
    Key? key,
    required this.partId,
    required this.userId,
  }) : super(key: key);

  @override
  _SearchLoadPageState createState() => _SearchLoadPageState();
}

class _SearchLoadPageState extends State<SearchLoadPage> {
  String? selectedManufacturer;
  String? selectedModel;
  String? selectedEngine;
  bool allDropdownsSelected = false;
  List<String> manufacturers = [];

  @override
  void initState() {
    super.initState();
    loadManufacturers();
  }
Future<void> loadManufacturers() async {
  try {
    final response = await http.get(Uri.parse(
        'https://bolide.armasoft.ci/bolide_services/index.php/api/maker/marque-pieces/'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('data') && data['data'] is List) {
        setState(() {
          manufacturers = (data['data'] as List)
              .map((item) => item['name'].toString())
              .where((name) => name.isNotEmpty)
              .toList();
        });
      } else {
        print('Unexpected data format: ${response.body}');
      }
    } else {
      print('Failed to load manufacturers: ${response.statusCode}');
    }
  } catch (e) {
    print('Error loading manufacturers: $e');
  }
}
  @override
  Widget build(BuildContext context) {
    bool isDropdownSelected = selectedManufacturer != null ||
        selectedModel != null ||
        selectedEngine != null;

    allDropdownsSelected = selectedManufacturer != null &&
        selectedModel != null &&
        selectedEngine != null;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 3.h),
              Row(
                children: [
                  SizedBox(height: 3.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 300),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  HomePage(
                            partId: widget.partId,
                            userId: widget.userId,
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const offsetBegin = Offset(-1.0, 0.0);
                            const offsetEnd = Offset.zero;
                            const curve = Curves.easeInOutCubic;

                            var tween =
                                Tween(begin: offsetBegin, end: offsetEnd)
                                    .chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                                position: offsetAnimation, child: child);
                          },
                        ),
                      );
                    },
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
              SizedBox(height: 3.h),
              Row(
                children: [
                  Text(
                    'Numéro de châssis',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    'assets/icons/cs.svg',
                    width: 5.w,
                    height: 5.w,
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              GestureDetector(
                onTap: () {
                  _showLoadingDialog(context);
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchResultPage(
                          partId: widget.partId,
                          userId: widget.userId,
                        ),
                      ),
                    );
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(1.5.w),
                    color: Colors.white,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/key.svg',
                        width: 5.w,
                        height: 5.w,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          'KM8 SRDHF5 EU123456',
                          style: TextStyle(
                            color: const Color(0xFF94979E),
                            fontFamily: 'Cabin',
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'ou',
                      style: TextStyle(
                          fontSize: 10.sp, color: const Color(0XFFC9CDD2)),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fabricant',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Choisissez une marque',
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 1.5.h, horizontal: 2.w),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    value: selectedManufacturer,
                    items: manufacturers.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, textAlign: TextAlign.center),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedManufacturer = newValue;
                        selectedModel = null;
                        selectedEngine = null;
                      });
                    },
                    icon: ImageIcon(
                      const AssetImage('assets/icons/dw.png'),
                      size: 4.w,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Text(
                    'Modèle',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Choisissez votre modèle',
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 1.5.h, horizontal: 2.w),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    value: selectedModel,
                    items: [
                      'Tucson',
                      'Nexo',
                      'Santa Fe',
                      'Kona',
                      'i30',
                      'i20',
                      'Ioniq 5'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, textAlign: TextAlign.center),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedModel = newValue;
                        selectedEngine = null;
                      });
                    },
                    icon: ImageIcon(
                      const AssetImage('assets/icons/dw.png'),
                      size: 4.w,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Text(
                    'Motorisation',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Choisissez votre moteur',
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 1.5.h, horizontal: 2.w),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    value: selectedEngine,
                    items: [
                      'Essence - 3.3 4WD (199 KW / 270 CV)',
                      'Essence - 2.0 (197 KW / 268 CV)',
                      'Essence - 2.0 4WD (197 KW / 268 CV)',
                      'Essence - 3.3 XL 4WD (218 KW / 296 CV)',
                      'Essence - 3.0 GDi (194 KW / 264 CV)',
                      'Diesel - 2.2 CRDi AWD (142 KW / 193 CV)',
                      'Diesel - 2.2 CRDi AWD (149 KW / 202 CV)',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, textAlign: TextAlign.center),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedEngine = newValue;
                      });
                    },
                    icon: ImageIcon(
                      const AssetImage('assets/icons/dw.png'),
                      size: 4.w,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              if (!isDropdownSelected)
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'ou',
                        style: TextStyle(
                            fontSize: 10.sp, color: const Color(0XFFC9CDD2)),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      ),
                    ),
                  ],
                ),
              if (isDropdownSelected && allDropdownsSelected)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        _showLoadingDialog(context);
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 300),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      SearchResult2Page(
                                partId: widget.partId,
                                userId: widget.userId,
                              ),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const offsetBegin = Offset(1.0, 0.0);
                                const offsetEnd = Offset.zero;
                                const curve = Curves.easeInOutCubic;

                                var tween =
                                    Tween(begin: offsetBegin, end: offsetEnd)
                                        .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                    position: offsetAnimation, child: child);
                              },
                            ),
                          );
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF1A1A1A),
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 8.0.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.5.w),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Rechercher...",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontFamily: 'Cabin',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 1.h),
              if (!isDropdownSelected)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFC9CDD2)),
                    borderRadius: BorderRadius.circular(1.5.w),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/whatsapp.svg',
                        width: 10.w,
                        height: 10.w,
                      ),
                      const SizedBox(width: 8.0),
                      const Expanded(
                        child: Text(
                          'Contacter par WhatsApp',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Cabin',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/icons/dt.png',
                        color: Colors.black,
                        height: 4.w,
                        width: 3.w,
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 1.h),
              if (!isDropdownSelected)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFC9CDD2)),
                    borderRadius: BorderRadius.circular(1.5.w),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/phone.svg',
                        width: 10.w,
                        height: 10.w,
                      ),
                      const SizedBox(width: 8.0),
                      const Expanded(
                        child: Text(
                          'Appeler un commercial',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Cabin',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/icons/dt.png',
                        color: Colors.black,
                        height: 4.w,
                        width: 3.w,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.all(0),
          child: Container(
            alignment: Alignment.center,
            color: Colors.transparent,
            child: SizedBox(
              width: 20.w,
              height: 20.w,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                strokeWidth: 6,
              ),
            ),
          ),
        );
      },
    );
  }
}
