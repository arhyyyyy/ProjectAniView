import 'package:aniview/data/repo/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthRepository _repo;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RegisterViewModel(this._repo);

  bool isLoading = false;
  String? errorMessage;

  Future<bool> register(String name, String email, String password) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      final user = await _repo.register(email, password);

      if (user == null) {
        errorMessage = "Registration failed.";
        return false;
      }

      // Simpan data user ke Firestore
      await firestore.collection("users").doc(user.uid).set({
        "uid": user.uid,
        "name": name,
        "email": email,
        "bio": "",
        "createdAt": DateTime.now().toIso8601String(),
      });

      return true;
    } on Exception catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
