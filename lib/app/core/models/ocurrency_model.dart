import 'dart:convert';

class OcurrencyModel {
  late int? protocol;
  late String? date;
  late String? description;
  late String? urlPhoto;
  late int? status;
  late String? postNumber;
  late double? latitude;
  late double? longitude;
  late String? userId;
  late String? address;
  late String? problemType;
  late String? urgency;
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
    this.address,
    this.problemType,
    this.urgency,
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
      'address': address,
      'problemType': problemType,
      'urgency': urgency,
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
      protocol: map['protocol'],
      address: map['address'],
      problemType: map['problemType'],
      urgency: map['urgency'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OcurrencyModel.fromJson(String source) =>
      OcurrencyModel.fromMap(json.decode(source));
}
