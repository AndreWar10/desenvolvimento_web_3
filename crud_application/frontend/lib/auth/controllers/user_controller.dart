import 'package:example_10_09/auth/models/user_model.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  UserController();

  UserModel? user;

  bool get userIsLoggedIn => user != null;

  void setUser(UserModel userData) {
    user = userData;
    notifyListeners();
  }
  

}