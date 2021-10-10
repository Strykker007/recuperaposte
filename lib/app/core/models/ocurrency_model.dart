import 'dart:convert';
import 'gps_model.dart';

class OcurrencyModel {
  late String? protocol;
  late DateTime? date;
  late String? description;
  late String? urlPhoto;
  late int? status;
  late String? postNumber;
  late GPSModel? location;
  OcurrencyModel({
    this.protocol,
    this.date,
    this.description,
    this.urlPhoto,
    this.status,
    this.postNumber,
    this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'protocol': protocol,
      'date': date,
      'description': description,
      'urlPhoto': urlPhoto,
      'status': status,
      'postNumber': postNumber,
      'location': location,
    };
  }

  factory OcurrencyModel.fromMap(Map<String, dynamic> map) {
    return OcurrencyModel(
      protocol: map['protocol'],
      date: map['date'],
      description: map['description'],
      urlPhoto: map['urlPhoto'],
      status: map['status'],
      postNumber: map['postNumber'],
      location: map['location'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OcurrencyModel.fromJson(String source) =>
      OcurrencyModel.fromMap(json.decode(source));
}
