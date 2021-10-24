import 'dart:convert';

class PostModel {
  late String? date;
  late String? urlPhoto;
  late String? postNumber;
  late double? latitude;
  late double? longitude;
  late String? postType;
  late String? iluminationType;
  late String? ocupation;
  late String? postState;
  PostModel({
    this.date,
    this.urlPhoto,
    this.postNumber,
    this.latitude,
    this.longitude,
    this.postType,
    this.iluminationType,
    this.ocupation,
    this.postState,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'urlPhoto': urlPhoto,
      'postNumber': postNumber,
      'latitude': latitude,
      'longitude': longitude,
      'postType': postType,
      'iluminationType': iluminationType,
      'ocupation': ocupation,
      'postState': postState,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      date: map['date'],
      urlPhoto: map['urlPhoto'],
      postNumber: map['postNumber'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      postType: map['postType'],
      iluminationType: map['iluminationType'],
      ocupation: map['ocupation'],
      postState: map['postState'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));
}
