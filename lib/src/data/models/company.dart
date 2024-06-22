import 'dart:convert';

class Company {
  final String id;
  final String name;

  Company({required this.id, required this.name});

  factory Company.fromMap(Map<String, dynamic> map) => Company(
        id: map['id'],
        name: map['name'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Company.fromJson(String json) => Company.fromMap(jsonDecode(json));

  String toJson() {
    return jsonEncode(toMap());
  }
}
