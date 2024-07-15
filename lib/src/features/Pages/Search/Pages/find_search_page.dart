import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_bolide/src/features/Pages/Home/Pay/Widgets/article2.dart';
import 'package:le_bolide/src/features/Pages/Home/pages/home_page.dart';
import 'package:le_bolide/src/features/Pages/Home/widgets/bar_search1.dart';
import 'package:le_bolide/src/features/Pages/Search/Pages/find_search_full_page.dart';
import 'package:le_bolide/src/features/Pages/Search/Pages/modal2_page.dart';
import 'package:le_bolide/src/features/Pages/Search/Pages/modal_page.dart';

import 'package:sizer/sizer.dart';

class FindSearchPage extends StatefulWidget {
  const FindSearchPage({super.key});

  @override
  _FindSearchPageState createState() => _FindSearchPageState();
}

class _FindSearchPageState extends State<FindSearchPage> {
  String _selectedButton = 'Tout';

  void _onButtonPressed(String buttonName) {
    if (!mounted) return;

    setState(() {
      _selectedButton = buttonName;
    });

    Future.microtask(() {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Ajout de la propriété backgroundColor
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 6.w),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (!mounted) return;

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
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
            const SearchBar1Widget(),
            SizedBox(height: 2.w),
            Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor:
                        _selectedButton == 'Tout' ? Colors.black : Colors.white,
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
            const Article2Page(),
            const Article2Page(),
            SizedBox(height: 9.w),
            Center(
              child: TextButton(
                onPressed: () {
                  if (!mounted) return;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FindSearchPlusPage()),
                  );
                },
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
    );
  }
}
