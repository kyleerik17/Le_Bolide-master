import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_bolide/screens/src/features/Pages/Home/Pay/Widgets/article3.dart';
import 'package:le_bolide/screens/src/features/Pages/Search/Pages/modal2_page.dart';
import 'package:le_bolide/screens/src/features/Pages/Search/Pages/modal_page.dart';

import 'package:sizer/sizer.dart';

import '../widgets/search1.dart';
import 'find_search_page.dart';

class FindSearchPlusPage extends StatefulWidget {
  const FindSearchPlusPage({Key? key}) : super(key: key);

  @override
  _FindSearchPlusState createState() => _FindSearchPlusState();
}

class _FindSearchPlusState extends State<FindSearchPlusPage> {
  String _selectedButton = 'Tout';

  void _onButtonPressed(String buttonName) {
    setState(() {
      _selectedButton = buttonName;
    });

    if (buttonName == 'Filtres') {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return const ModalPage();
        },
      );
    } else if (buttonName == 'Trier par') {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return const Modal2Page();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Ajout de la propriété backgroundColor
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 6.w),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FindSearchPage()),
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
              SizedBox(height: 5.w),
              const Search1BarWidget(),
              SizedBox(height: 2.w),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                      ),
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
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.5.h),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      minimumSize: Size(0, 3.8.h),
                    ),
                    onPressed: () => _onButtonPressed('Filtres'),
                    child: Row(
                      children: [
                        const Text(
                          'Filtres',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 1.w),
                        Image.asset(
                          'assets/icons/fltr.png',
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Gap(2.w),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.5.h),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                      ),
                      minimumSize: Size(0, 3.8.h),
                    ),
                    onPressed: () => _onButtonPressed('Trier par'),
                    child: Row(
                      children: [
                        const Text(
                          'Trier par',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 1.w),
                        Image.asset(
                          'assets/icons/fltr.png',
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.w),
             const Article3Page(categoryId: 1),
              const Article3Page(categoryId: 1),
               const Article3Page(categoryId: 1),
                const Article3Page(categoryId: 1),
              SizedBox(height: 9.w),
              Center(
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    padding:
                        EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 35.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.w),
                    ),
                  ),
                  child: Text(
                    "Charger plus",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Cabin',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
