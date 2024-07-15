import 'package:flutter/material.dart';
import 'package:le_bolide/src/features/Pages/Home/pages/Categories/pages/pages.dart';
import 'package:sizer/sizer.dart';

class Categorie extends StatelessWidget {
  const Categorie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCategorie(
            icon: 'assets/icons/care.png',
            label: 'Poids lourds',
            onTap: () {
              // Redirection vers Le PSG
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => TerrainPage()),
              // );
            },
          ),
          SizedBox(width: 2.w),
          _buildCategorie(
            icon: 'assets/icons/moto.png',
            label: 'Moto',
            onTap: () {
              // Redirection vers The Bulls
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => TerrainPage()),
              // );
            },
          ),
          SizedBox(width: 2.w),
          _buildCategorie(
            icon: 'assets/icons/roue.png',
            label: 'Pneus',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PneuPage()),
              );
            },
          ),
          SizedBox(width: 2.w),
          _buildCategorie(
            icon: 'assets/icons/tl.png',
            label: 'Outillage',
            onTap: () {
              // Redirection vers une autre page
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => TerrainPage()),
              // );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategorie({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 25.w,
            height: 25.w,
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Center(
              child: Image.asset(
                icon,
                width: 12.w,
                height: 12.w,
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            label,
            style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Cabin'),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
