import 'package:flutter/material.dart';
import 'package:Bolide/screens/src/features/Pages/Home/pages/home_page.dart';
import 'package:Bolide/screens/src/features/Pages/Search/Pages/find_search_full_page.dart';
import 'package:sizer/sizer.dart';
import '../../Search/Pages/find_search_page.dart';

class Search2 extends StatelessWidget {
  final int partId;
  final int userId;

  const Search2({
    Key? key,
    required this.partId,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 132,
      child: Container(
        width: 358,
        height: 40,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
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
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (_, __, ___) => FindSearchPage(
                  partId: partId,
                  userId: userId,
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
          decoration: const InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            hintText: 'Rechercher...',
            hintStyle: TextStyle(
              color: Color(0xFF737373),
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 0),
              child: ImageIcon(
                AssetImage('assets/icons/search.png'),
                size: 16,
                color: Colors.black,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 9),
          ),
          style: const TextStyle(
            color: Color(0xFF737373),
          ),
        ),
      ),
    );
  }
}
