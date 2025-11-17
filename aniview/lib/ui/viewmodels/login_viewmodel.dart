import 'package:aniview/data/repo/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _repo;

  LoginViewModel(this._repo);

  bool isLoading = false;

  Future<String?> login(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      await _repo.login(email, password);
      return null; // success
    } on Exception catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == "user-not-found") return "Email is not registered.";
        if (e.code == "wrong-password") return "Incorrect password.";
        if (e.code == "invalid-email") return "Invalid email format.";
      }
      return "Login failed.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
