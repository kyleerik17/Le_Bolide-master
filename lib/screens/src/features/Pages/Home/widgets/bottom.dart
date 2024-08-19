import 'package:Bolide/screens/src/features/Pages/Assistance/pages/assistance_page.dart';
import 'package:Bolide/screens/src/features/Pages/Favoris/Pages/favoris_page.dart';
import 'package:Bolide/screens/src/features/Pages/Home/pages/home_page.dart';
import 'package:Bolide/screens/src/features/Pages/commande/pages/commande_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class BottomNavBar extends StatefulWidget {
  final int partId;
  final int userId;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.onTap,
    required this.partId,
    required this.userId,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 1.5.w,
          child: const LinearProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            value: 0.2,
          ),
        ),
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedFontSize: 10.sp,
          unselectedFontSize: 10.sp,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                  widget.onTap(0);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                            partId: widget.partId, userId: widget.userId)),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1.w),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/icons/h.png',
                        height: 8.w,
                        width: 8.w,
                        color: Colors.black,
                      ),
                      const Text(
                        'Acceuil',
                        style: TextStyle(
                          fontFamily: "Cabin",
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                  widget.onTap(1);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CommandePage(
                            partId: widget.partId, userId: widget.userId)),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1.w),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/reciept.svg',
                        height: 8.w,
                        width: 8.w,
                      ),
                      const Text(
                        'Commandes',
                        style: TextStyle(
                            fontFamily: "Cabin",
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF737373)),
                      ),
                    ],
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {},
                child: Container(),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                  widget.onTap(3);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AssistancePage(
                            partId: widget.partId, userId: widget.userId)),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1.w),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/life-ring.svg',
                        height: 8.w,
                        width: 8.w,
                      ),
                      const Text(
                        'Assistance',
                        style: TextStyle(
                          fontFamily: "Cabin",
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF737373),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 4;
                  });
                  widget.onTap(4);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FavorisPage(
                            partId: widget.partId, userId: widget.userId)),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1.w),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/heart.svg',
                        height: 8.w,
                        width: 8.w,
                      ),
                      const Text(
                        'Favoris',
                        style: TextStyle(
                          fontFamily: "Cabin",
                          color: Color(0xFF737373),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              label: '',
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            widget.onTap(index);
          },
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import '../../Assistance/pages/assistance_page.dart';
// import '../../Favoris/Pages/favoris.dart';
// import '../../commande/pages/pages.dart';

// class CustomBottomNavBar extends StatelessWidget {
//   final int selectedIndex;
//   final int partId;
//   final int userId;
//   final Function(int) onItemTapped;

//   const CustomBottomNavBar({
//     Key? key,
//     required this.selectedIndex,
//     required this.partId,
//     required this.userId,
//     required this.onItemTapped,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         SizedBox(
//           height: 1.5.w,
//           child: const LinearProgressIndicator(
//             backgroundColor: Colors.white,
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
//             value: 0.2,
//           ),
//         ),
//         Container(
//           height: 60,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.3),
//                 spreadRadius: 1,
//                 blurRadius: 5,
//                 offset: const Offset(0, -1),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildNavItem(0, 'assets/icons/h.png', 'Accueil'),
//               _buildNavItem(1, 'assets/icons/rec.png', 'Commandes'),
//               _buildSearchButton(),
//               _buildNavItem(3, 'assets/icons/ring.png', 'Assistance'),
//               _buildNavItem(4, 'assets/icons/cr.png', 'Favoris'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildNavItem(int index, String iconPath, String label) {
//     bool isSelected = selectedIndex == index;
//     return GestureDetector(
//       onTap: () => _handleNavigation(index),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             iconPath,
//             height: 8.w,
//             width: 8.w,
//             color: isSelected ? Colors.black : const Color(0xFF737373),
//           ),
//           Text(
//             label,
//             style: TextStyle(
//               fontFamily: "Cabin",
//               fontWeight: FontWeight.w600,
//               fontSize: 10.sp,
//               color: isSelected ? Colors.black : const Color(0xFF737373),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchButton() {
//     return GestureDetector(
//       onTap: () => onItemTapped(2),
//       child: Container(
//         width: 15.w,
//         height: 15.w,
//         decoration: const BoxDecoration(
//           color: Colors.black,
//           shape: BoxShape.circle,
//         ),
//         child: Icon(
//           Icons.search,
//           color: Colors.white,
//           size: 8.w,
//         ),
//       ),
//     );
//   }

//   void _handleNavigation(int index) {
//     onItemTapped(index);
//     // Vous pouvez ajouter ici la logique de navigation si nécessaire
//   }
// }