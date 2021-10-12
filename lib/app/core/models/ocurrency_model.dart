import 'dart:convert';

class OcurrencyModel {
  late String? protocol;
  late String? date;
  late String? description;
  late String? urlPhoto;
  late int? status;
  late String? postNumber;
  late double? latitude;
  late double? longitude;
  late String? userId;
  OcurrencyModel({
    this.protocol,
    this.date,
    this.description,
    this.urlPhoto,
    this.status,
    this.postNumber,
    this.latitude,
    this.longitude,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'protocol': protocol,
      'date': date,
      'description': description,
      'urlPhoto': urlPhoto,
      'status': status,
      'postNumber': postNumber,
      'latitude': latitude,
      'longitude': longitude,
      'userId': userId,
    };
  }

  factory OcurrencyModel.fromMap(Map<String, dynamic> map) {
    return OcurrencyModel(
      date: map['date'],
      description: map['description'],
      urlPhoto: map['urlPhoto'],
      status: map['status'],
      postNumber: map['postNumber'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      userId: map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OcurrencyModel.fromJson(String source) =>
      OcurrencyModel.fromMap(json.decode(source));
}
