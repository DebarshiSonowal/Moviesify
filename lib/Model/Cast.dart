import 'dart:convert';

class cast {
  int id, cast_id;
  String profile_path, name, character;

  cast({this.id, this.cast_id, this.profile_path, this.name, this.character});

  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$profile_path';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cast_id': cast_id,
      'profile_path': profile_path,
      'name': name,
      'character': character
    };
  }

  factory cast.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return cast(
          id: 0,
          cast_id: 1,
          name: 'name',
          profile_path: 'logo_path',
          character: 'character');
    }
    return cast(
      id: map['id'],
      name: map['name'],
      cast_id: map['cast_id'],
      profile_path: map['profile_path'],
      character: map['character'],
    );
  }

  String toJson() => json.encode(toMap);

  factory cast.fromJson(String source) =>
      cast.fromMap(json.decode(source));
}
