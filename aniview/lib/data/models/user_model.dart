class UserModel {
  final String uid;
  final String name;
  final String email;
  final String bio;
  final String createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.bio,
    required this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      bio: map['bio'] ?? "",
      createdAt: map['createdAt'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "bio": bio,
      "createdAt": createdAt,
    };
  }
}
