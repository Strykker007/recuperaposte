import 'dart:convert';

class GPSModel {
  late int coordinateX;
  late int coordinateY;
  GPSModel({
    required this.coordinateX,
    required this.coordinateY,
  });

  Map<String, dynamic> toMap() {
    return {
      'coordinateX': coordinateX,
      'coordinateY': coordinateY,
    };
  }

  factory GPSModel.fromMap(Map<String, dynamic> map) {
    return GPSModel(
      coordinateX: map['coordinateX'],
      coordinateY: map['coordinateY'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GPSModel.fromJson(String source) =>
      GPSModel.fromMap(json.decode(source));
}
