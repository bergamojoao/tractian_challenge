class Company {
  final String id;
  final String name;

  Company({required this.id, required this.name});

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json['id'],
        name: json['name'],
      );
}