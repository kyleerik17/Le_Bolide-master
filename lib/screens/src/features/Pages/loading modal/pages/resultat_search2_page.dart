import 'package:Bolide/screens/src/features/Pages/Search/Pages/find_search_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearchResult2Page extends StatefulWidget {
  final int userId;
  final int partId;
  const SearchResult2Page(
      {Key? key, required this.userId, required this.partId})
      : super(key: key);

  @override
  _SearchResult2PageState createState() => _SearchResult2PageState();
}

class _SearchResult2PageState extends State<SearchResult2Page> {
  String? selectedManufacturer;
  String? selectedModel;
  String? selectedEngine;
  bool allDropdownsSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 3.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFEBEBEB),
                      ),
                      padding: const EdgeInsets.all(0),
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
              SizedBox(height: 2.h),
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
                      hintText: 'Hyundai',
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                    ),
                    value: selectedManufacturer,
                    items: ['Hyundai', 'Toyota', 'Ford', 'BMW']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
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
                      size: 3.w,
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
                      hintText: 'Santa Fe',
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                    ),
                    value: selectedModel,
                    items:
                        ['i30', 'Corolla', 'Mustang', 'X5'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
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
                      size: 3.w,
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
                      hintText: 'Essence',
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                    ),
                    value: selectedEngine,
                    items: ['Essence', 'Diesel', 'Électrique', 'Hybride']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedEngine = newValue;
                      });
                    },
                    icon: ImageIcon(
                      const AssetImage('assets/icons/dw.png'),
                      size: 3.w,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.5.h),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hyundai SANTA FE',
                      style: TextStyle(
                        color: const Color(0xFF1F1F1F),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 28.sp,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Image.asset(
                      'assets/images/crhd.png',
                      width: 80.w,
                    ),
                  ],
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 300),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            FindSearchPage(
                          partId: widget.partId,
                          userId: widget.userId,
                        ),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const offsetBegin =
                              Offset(1.0, 0.0); // Start from left
                          const offsetEnd =
                              Offset.zero; // End at the current position
                          const curve = Curves.easeInOutCubic; // Smooth curve

                          var tween = Tween(begin: offsetBegin, end: offsetEnd)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                              position: offsetAnimation, child: child);
                        },
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 8.0.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.5.w),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/icons/home.png',
                        width: 5.w,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        "Voir les pièces",
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
              SizedBox(height: 3.h),
              Container(
                height: 3.h,
                width: double.infinity,
                color: const Color(0xFFF3F3F3),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Fabricant : ',
                        style: TextStyle(
                          color: const Color(0xFF1F1F1F),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                      TextSpan(
                        text: 'Hyundai',
                        style: TextStyle(
                          color: const Color(0xFF1F1F1F),
                          fontFamily: 'Cabin',
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                color: const Color(0xFFF3F3F3),
                width: double.infinity,
                height: 30.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.w),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '  Type de véhicule : ',
                            style: TextStyle(
                              color: const Color(0xFF1F1F1F),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRichTextWithIcon('   Modèle : ', 'Santa Fe'),
                          _buildRichTextWithIcon(
                              '   Type de carrosserie : ', 'SUV'),
                          _buildRichTextWithIcon(
                              '   Type de moteur : ', 'Essence V6 3.3L'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.w),
              Container(
                height: 3.h,
                width: double.infinity,
                color: const Color(0xFFF3F3F3),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Année de fabrication : ',
                        style: TextStyle(
                          color: const Color(0xFF1F1F1F),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                      TextSpan(
                        text: '2014',
                        style: TextStyle(
                          color: const Color(0xFF1F1F1F),
                          fontFamily: 'Cabin',
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.w),
              Container(
                height: 3.h,
                width: double.infinity,
                color: const Color(0xFFF3F3F3),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Lieu de fabrication : ',
                        style: TextStyle(
                          color: const Color(0xFF1F1F1F),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                      TextSpan(
                        text: 'Ulsan, Corée du Sud',
                        style: TextStyle(
                          color: const Color(0xFF1F1F1F),
                          fontFamily: 'Cabin',
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.w),
              Container(
                color: const Color(0xFFF3F3F3),
                width: double.infinity,
                height: 30.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.w),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '  Caractéristiques du véhicule : ',
                            style: TextStyle(
                              color: const Color(0xFF1F1F1F),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRichTextWithIcon(
                              '   Transmission : ', 'Automatique'),
                          _buildRichTextWithIcon(
                              '   Type de carburant : ', 'Essence'),
                          _buildRichTextWithIcon(
                              '   Cylindrée du moteur : ', '3.3L'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.w),
              Container(
                height: 3.h,
                width: double.infinity,
                color: const Color(0xFFF3F3F3),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Année de fabrication : ',
                        style: TextStyle(
                          color: const Color(0xFF1F1F1F),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                      TextSpan(
                        text: '2014',
                        style: TextStyle(
                          color: const Color(0xFF1F1F1F),
                          fontFamily: 'Cabin',
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.w),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRichTextWithIcon(String title, String content) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Baseline(
              baselineType: TextBaseline.alphabetic,
              baseline: 18.sp,
              child: Icon(Icons.circle, size: 2.w),
            ),
          ),
          TextSpan(
            text: title,
            style: TextStyle(
              color: const Color(0xFF1F1F1F),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 12.sp,
            ),
          ),
          TextSpan(
            text: content,
            style: TextStyle(
              color: const Color(0xFF1F1F1F),
              fontFamily: 'Cabin',
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
