// // lib/screens/logout_page.dart
// import 'package:flutter/material.dart';
// import 'package:le_bolide/data/services/user_provider.dart';
// import 'package:provider/provider.dart';
// import '../providers/user_provider.dart';

// class LogoutPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Déconnexion'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Provider.of<UserProvider>(context, listen: false).clearUser();
//             Navigator.pushReplacementNamed(context, '/RegistrationPage'); // Remplacez par votre route de connexion
//           },
//           child: Text('Se déconnecter'),
//         ),
//       ),
//     );
//   }
// }
