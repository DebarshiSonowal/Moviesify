
import 'dart:convert';

class tvshow {

  int id;
  String name, poster_path;
  dynamic vote_average;
  List<dynamic> genre_ids;

  tvshow(
      {this.name,
        this.poster_path,
        this.vote_average,
        this.genre_ids,
        this.id});

  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$poster_path';

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'poster_path': poster_path,
      'vote_average': vote_average,
      'genre_ids': genre_ids,
      'id': id
    };
  }

  factory tvshow.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return tvshow(
          name: '',
          poster_path: '',
          vote_average: 0,
          genre_ids: [1, 2],
          id: 1);
    }
    return tvshow(
        name: map['name'],
        poster_path: map['poster_path'],
        vote_average: map['vote_average'],
        genre_ids: map['genre_ids'],
        id: map['id']);
  }

  String toJson() => json.encode(toMap);

  factory tvshow.fromJson(String source) => tvshow.fromMap(json.decode(source));

}