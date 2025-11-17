import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../../data/repo/user_repository.dart';

enum ProfileState { idle, loading, error }

class ProfileViewModel extends ChangeNotifier {
  final UserRepository repository;

  ProfileViewModel({required this.repository});

  ProfileState state = ProfileState.idle;
  String? errorMessage;
  UserModel? user;

  Future<void> loadProfile() async {
    try {
      state = ProfileState.loading;
      notifyListeners();
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        state = ProfileState.error;
        errorMessage = "User not logged in";
        notifyListeners();
        return;
      }
      final fetched = await repository.getUser(currentUser.uid);
      user = UserModel(
        uid: fetched.uid,
        name: fetched.name,
        email: fetched.email,
        bio: fetched.bio,
        createdAt: fetched.createdAt,
      );
      state = ProfileState.idle;
    } catch (e) {
      state = ProfileState.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> logout() async {
  try {
    state = ProfileState.loading;
    notifyListeners();

    await FirebaseAuth.instance.signOut();

    user = null;
    state = ProfileState.idle;
  } catch (e) {
    state = ProfileState.error;
    errorMessage = e.toString();
  }

  notifyListeners();
}

}
