import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileRepository {
  final _fire = FirebaseFirestore.instance;

  Future<void> updateProfile(String uid, Map<String, dynamic> data) async {
    await _fire.collection("users").doc(uid).update(data);
  }
}
