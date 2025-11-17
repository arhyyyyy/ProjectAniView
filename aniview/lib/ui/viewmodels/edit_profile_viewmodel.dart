import 'package:flutter/material.dart';
import '../../data/repo/profile_repository.dart';
import '../viewmodels/profile_viewmodel.dart';

enum EditState { idle, loading, success, error }

class EditProfileViewModel extends ChangeNotifier {
  final ProfileRepository repo;
  final ProfileViewModel profileVM;

  EditProfileViewModel(this.repo, this.profileVM);

  EditState state = EditState.idle;
  String? errorMessage;

  Future<void> updateProfile(String uid, Map<String, dynamic> data) async {
    try {
      state = EditState.loading;
      notifyListeners();

      await repo.updateProfile(uid, data);

      await profileVM.loadProfile();

      state = EditState.success;
    } catch (e) {
      errorMessage = e.toString();
      state = EditState.error;
    }

    notifyListeners();
  }
}
