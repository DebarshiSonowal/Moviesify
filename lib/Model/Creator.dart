

import 'dart:convert';

class creator_model {
  int id,gender;
  String name,profile_path;


  creator_model({this.id, this.gender, this.name, this.profile_path});

  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$profile_path';

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profile_path': profile_path,
      'gender': gender,
      'id': id
    };
  }

  factory creator_model.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return creator_model(
          name: '',
          profile_path: '',
          gender: 2,
          id: 1);
    }
    return creator_model(
        name: map['name'],
        profile_path: map['profile_path'],
        gender: map['gender'],
        id: map['id']);
  }

  String toJson() => json.encode(toMap);

  factory creator_model.fromJson(String source) => creator_model.fromMap(json.decode(source));

}
