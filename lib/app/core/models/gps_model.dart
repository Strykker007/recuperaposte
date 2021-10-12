import 'dart:convert';

class GPSModel {
  late double latitude;
  late double longitude;
  GPSModel({
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory GPSModel.fromMap(Map<String, dynamic> map) {
    return GPSModel(
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GPSModel.fromJson(String source) =>
      GPSModel.fromMap(json.decode(source));
}
