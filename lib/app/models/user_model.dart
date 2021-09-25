import 'dart:convert';

class UserModel {
  late String? name;
  late String? username;
  late String? avatarUrl;
  late String? email;
  late bool? isAdmin;
  UserModel({
    this.name,
    this.username,
    this.avatarUrl,
    this.email,
    this.isAdmin,
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
