import 'dart:convert';

class UserModel {
  String name;
  String username;
  String avatarUrl;
  String email;
  bool isAdmin;
  UserModel({
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.email,
    required this.isAdmin,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'avatarUrl': avatarUrl,
      'email': email,
      'isAdmin': isAdmin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      username: map['username'],
      avatarUrl: map['avatarUrl'],
      email: map['email'],
      isAdmin: map['isAdmin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
