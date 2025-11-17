import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirebaseFirestore firestore;

  UserRepository({required this.firestore});

  Future<UserModel> getUser(String uid) async {
    final snap = await firestore.collection("users").doc(uid).get();

    if (!snap.exists) {
      throw Exception("User not found");
    }

    return UserModel.fromMap(snap.data()!);
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await firestore.collection("users").doc(uid).update(data);
  }
}
