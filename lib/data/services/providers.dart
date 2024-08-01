import 'package:flutter/material.dart';
import 'package:le_bolide/data/services/user.dart';
import 'package:provider/provider.dart';


class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    if (user == null) {
      return Scaffold(
        body: Center(child: Text('Utilisateur non connecté')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Profil Utilisateur')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nom: ${user.name}'),
            Text('Prénom: ${user.surname}'),
            Text('Téléphone: ${user.phone}'),
          ],
        ),
      ),
    );
  }
}

