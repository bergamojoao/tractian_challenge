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

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        id: json['id'],
        name: json['name'],
        parentId: json['name'],
      );
}
