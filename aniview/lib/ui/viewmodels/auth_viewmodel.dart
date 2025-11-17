import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  Future<bool> register(String name, String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await userCredential.user!.updateDisplayName(name);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .set({
        "uid": userCredential.user!.uid,
        "name": name,
        "email": email,
        "createdAt": DateTime.now().toIso8601String(),
      });

      errorMessage = null;
      return true;

    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        errorMessage = "Email already registered.";
      } else if (e.code == "invalid-email") {
        errorMessage = "Invalid email format.";
      } else if (e.code == "weak-password") {
        errorMessage = "Password is too weak.";
      } else {
        errorMessage = "Something went wrong.";
      }
      return false;

    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}