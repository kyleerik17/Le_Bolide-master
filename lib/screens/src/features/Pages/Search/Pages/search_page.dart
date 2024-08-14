import 'package:flutter/material.dart';
import 'package:Bolide/screens/src/features/Pages/Home/pages/home_page.dart';
import 'package:sizer/sizer.dart';

import 'find_search_page.dart';

class SearchPage extends StatelessWidget {
  final int partId;
  final int quantity;
  final int userId;
  const SearchPage(
      {Key? key,
      required this.partId,
      required this.quantity,
      required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            SizedBox(height: 6.w),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                userId: userId,
                                partId: partId,
                              )),
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
            SizedBox(height: 4.w),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FindSearchPage(
                            partId: partId,
                            userId: userId,
                          )),
                );
              },
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Rechercher',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(1.5.w),
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
