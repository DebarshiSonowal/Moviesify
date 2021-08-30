import 'dart:convert';

class Genres {
  int id;
  String name;

  Genres({this.id, this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Genres.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return Genres(
        id: null,
        name: '',
      );
    }
    return Genres(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap);

  factory Genres.fromJson(String source) => Genres.fromMap(json.decode(source));
}
