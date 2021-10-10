import 'dart:convert';

class UserModel {
  late String? id;
  late String? name;
  late String? avatarUrl;
  late String? email;
  late bool? isAdmin;
  late String? address;
  UserModel({
    this.id,
    this.name,
    this.avatarUrl,
    this.email,
    this.isAdmin,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'email': email,
      'isAdmin': isAdmin,
      'address': address
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      avatarUrl: map['avatarUrl'],
      email: map['email'],
      isAdmin: map['isAdmin'],
      address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
