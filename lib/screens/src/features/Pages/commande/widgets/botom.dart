// import 'package:Bolide/screens/src/features/Pages/Assistance/pages/assistance_page.dart';
// import 'package:Bolide/screens/src/features/Pages/Home/pages/home_page.dart';
// import 'package:Bolide/screens/src/features/Pages/commande/pages/commande_page.dart';
// import 'package:flutter/material.dart';

// import '../../Favoris/Pages/favoris_page.dart';




// class BotomPage extends StatefulWidget {
//   const BotomPage({super.key});

//   @override
//   _BotomPageState createState() => _BotomPageState();
// }

// class _BotomPageState extends State<BotomPage> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = [
//     const HomePage(partId: 0,userId: 1,),
//     const CommandePage(partId: 0,userId: 1,),
//     const AssistancePage(partId: 0,userId: 1,),
//     const FavorisPage(partId: 0,userId: 1,),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart),
//             label: 'Commande',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.assistant),
//             label: 'Assistance',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Favoris',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

