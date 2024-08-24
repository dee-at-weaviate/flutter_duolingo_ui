import 'package:flutter/material.dart';

class User {
  final String? name;
  final String? email;

  User({required this.name, required this.email});
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