import 'dart:convert';

class Asset {
  final String id;
  final String name;
  final String? parentId;
  final String? locationId;
  final String? sensorId;
  final String? sensorType;
  final String? status;
  final String? gatewayId;

  Asset({
    required this.id,
    required this.name,
    this.parentId,
    this.locationId,
    this.sensorId,
    this.sensorType,
    this.status,
    this.gatewayId,
  });

  factory Asset.fromMap(Map<String, dynamic> map) => Asset(
        id: map['id'],
        name: map['name'],
        parentId: map['parentId'],
        locationId: map['locationId'],
        sensorId: map['sensorId'],
        sensorType: map['sensorType'],
        status: map['status'],
        gatewayId: map['gatewayId'],
      );

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'parentId': parentId, 'type': 'asset'};
  }

  factory Asset.fromJson(String json) => Asset.fromMap(jsonDecode(json));

  String toJson() {
    return jsonEncode(toMap());
  }
}
