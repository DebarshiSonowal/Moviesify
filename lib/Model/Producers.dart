import 'dart:convert';

class producer {
  int id;
  String name, logo_path;

  producer({this.id, this.name, this.logo_path});

  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$logo_path';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'logo_path': logo_path,
      'name': name,
    };
  }

  factory producer.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return producer(
        id: 0,
        name: 'name',
        logo_path: 'logo_path',
      );
    }
    return producer(
        id: map['id'],
        name: map['name'],
        logo_path: map['logo_path'],
    );
  }

  String toJson() => json.encode(toMap);

  factory producer.fromJson(String source) =>
      producer.fromMap(json.decode(source));
}
