import 'package:flutter/material.dart';

import '../../home_page.dart';
import 'pneu_page.dart';


class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const HomePage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(-1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        final tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        final offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
          },
          child: Image.asset(
            'assets/icons/gc.png',
            width: 40,
            height: 40,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Catégories',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFFCFCFC),
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            const CategoryItem(
                icon: 'assets/icons/voiture.png', label: 'Voiture'),
            const CategoryItem(icon: 'assets/icons/moto.png', label: 'Moto'),
           GestureDetector(
  onTap: () {
    Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const PneuPage(categoryId: '', categoryDetails: {},),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        final tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        final offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
  },
  child: const CategoryItem(
    icon: 'assets/icons/rng.png', 
    label: 'Pneus',
  ),
),

            const CategoryItem(icon: 'assets/icons/tl.png', label: 'Outillage'),
            const CategoryItem(
                icon: 'assets/icons/acc.png', label: 'Accessoires Auto'),
            const CategoryItem(
                icon: 'assets/icons/hll.png', label: 'Huile moteur'),
            const CategoryItem(
                icon: 'assets/icons/filtre.png', label: 'Filtre'),
            const CategoryItem(
                icon: 'assets/icons/freins.png', label: 'Freins'),
            const CategoryItem(
                icon: 'assets/icons/ess.png', label: 'Électromobilité'),
            const CategoryItem(
                icon: 'assets/icons/care.png', label: 'Poids lourds'),
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String icon;
  final String label;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Image.asset(
              icon,
              width: 60,
              height: 60,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
