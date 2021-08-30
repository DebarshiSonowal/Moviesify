import 'dart:convert';

class result {
  String name;
  int id;

  result({this.name, this.id});

  Map<String, dynamic> toMap() {
    return {'name': name, 'id': id};
  }

  factory result.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return result(name: '', id: 1);
    }
    return result(name: map['name'], id: map['id']);
  }

  String toJson() => json.encode(toMap);

  factory result.fromJson(String source) => result.fromMap(json.decode(source));
}
