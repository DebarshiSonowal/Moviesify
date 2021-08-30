import 'package:flutter/material.dart';
import 'dart:convert';

class Movie {
  int id;
  String title, poster_path;
  dynamic vote_average;
  bool adult;
  List<dynamic> genre_ids;

  Movie(
      {@required this.title,
      @required this.poster_path,
      this.vote_average,
      this.adult,
      this.genre_ids,
      this.id});

  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$poster_path';

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'poster_path': poster_path,
      'vote_average': vote_average,
      'adult': adult,
      'genre_ids': genre_ids,
      'id': id
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return Movie(
          title: '',
          poster_path: '',
          vote_average: 0,
          adult: false,
          genre_ids: [1, 2],
          id: 1);
    }
    return Movie(
        title: map['title'],
        poster_path: map['poster_path'],
        vote_average: map['vote_average'],
        adult: map['adult'],
        genre_ids: map['genre_ids'],
        id: map['id']);
  }

  String toJson() => json.encode(toMap);

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}
