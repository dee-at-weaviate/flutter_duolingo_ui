import 'package:duolingo/util/api.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class User {
  final String? name;
  final String? email;
  final String? userID;

  User({required this.name, required this.email, required this.userID});

  static Future<User> createNew(username, email) async {
    try {
      String url = "user/new";
      final Map<String, dynamic> data = {
        'username': username,
        'email' : email
      };
      final response = await API.post(url, json.encode(data));
      logger.info('back from post create new user');
      logger.info(response);  
      User user = User(name: response['username'] , email: response['email'], userID: response['user_id']);
      return user;
    } catch (e) {
      logger.fine('in error');
      logger.fine(e);
      return Future.error(e);
      // return [];
    }
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