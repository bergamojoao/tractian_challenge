import 'dart:convert';

import 'asset.dart';
import 'location.dart';

class Company {
  final String id;
  final String name;
  List<Location> locations = [];
  List<Asset> assets = [];

  Company({
    required this.id,
    required this.name,
    this.locations = const [],
    this.assets = const [],
  });

  factory Company.fromMap(Map<String, dynamic> map) => Company(
        id: map['id'],
        name: map['name'],
        locations: map['locations'] != null
            ? (map['locations'] as List)
                .map((e) => Location.fromMap(e))
                .toList()
            : [],
        assets: map['assets'] != null
            ? (map['assets'] as List).map((e) => Asset.fromMap(e)).toList()
            : [],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': 'company',
      'locations': locations.map((e) => e.toMap()).toList(),
      'assets': assets.map((e) => e.toMap()).toList()
    };
  }

  factory Company.fromJson(String json) => Company.fromMap(jsonDecode(json));

  String toJson() {
    return jsonEncode(toMap());
  }
}
