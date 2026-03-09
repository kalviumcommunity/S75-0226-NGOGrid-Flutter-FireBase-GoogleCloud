import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class UserProvider with ChangeNotifier {
  UserModel? _userModel;
  final AuthService _authService = AuthService();

  UserModel? get user => _userModel;

  bool get isAdmin => _userModel?.role == UserRole.admin;

  Future<void> loadUser(String uid) async {
    _userModel = await _authService.getUserData(uid);
    notifyListeners();
  }

  void clearUser() {
    _userModel = null;
    notifyListeners();
  }
}
