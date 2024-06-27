import 'dart:convert';

class Location {
  final String id;
  final String name;
  final String? parentId;

  Location({required this.id, required this.name, this.parentId});

  factory Location.fromMap(Map<String, dynamic> map) => Location(
        id: map['id'],
        name: map['name'],
        parentId: map['parentId'],
      );

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'parentId': parentId, 'type': 'location'};
  }

  factory Location.fromJson(String json) => Location.fromMap(jsonDecode(json));

  String toJson() {
    return jsonEncode(toMap());
  }
}
