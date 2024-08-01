import 'package:flutter/foundation.dart';

class User {
  final int id;
  final String name;
  final String surname;
  final String phone;

  User({required this.id, required this.name, required this.surname, required this.phone});
  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      phone: json['phone']);
      toJson() {
    var json = <String, dynamic>{};

    json['"id"'] = id;
    json['"name"'] = '"$name"';
    json['"surname"'] = '"$surname"';
    json['"phone"'] = '"$phone"';
 

    return json;
  }
}

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}