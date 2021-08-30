import 'dart:convert';

import 'package:movieslist/Model/Creator.dart';
import 'package:movieslist/Model/Genres.dart';
import 'package:movieslist/Model/Season.dart';
import 'package:movieslist/UI/Widgets/ProducerSection.dart';

class tvdetails {
  String first_air_date, last_air_date, name, overview, poster_path, status,backdrop_path;
  int number_of_seasons, number_of_episodes, id;
  dynamic vote_average;
  List<dynamic> genre_ids,creator,producers,seasons;

  tvdetails(
      {this.first_air_date,
      this.last_air_date,
      this.name,
      this.overview,
      this.poster_path,
      this.status,
      this.number_of_seasons,
      this.number_of_episodes,
      this.id,
      this.vote_average,
      this.creator,
      this.seasons,
      this.genre_ids,
      this.producers,this.backdrop_path});

  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$poster_path';
  String get fullImageBgUrl => 'https://image.tmdb.org/t/p/w200$backdrop_path';

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'poster_path': poster_path,
      'vote_average': vote_average,
      'genre_ids': genre_ids,
      'overview': overview,
      'status': status,
      'number_of_seasons': number_of_seasons,
      'number_of_episodes': number_of_episodes,
      'creator': creator,
      'seasons': seasons,
      'first_air_date': first_air_date,
      'last_air_date': last_air_date,
      'producers': producers,
      'id': id,
      'backdrop_path':backdrop_path
    };
  }

  factory tvdetails.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return tvdetails(
          name: '',
          poster_path: '',
          vote_average: 0,
          genre_ids: [],
          overview: '',
          status: '',
          number_of_seasons: 0,
          creator: [],
          seasons: [],
          first_air_date: '',
          last_air_date: '',
          producers: [],
          id: 1,
          backdrop_path:'');
    }
    return tvdetails(
      name: map['name'],
      poster_path: map['poster_path'],
      vote_average: map['vote_average'],
      genre_ids: map['genres'],
      id: map['id'],
      overview: map['overview'],
      status: map['status'],
      creator: map['created_by'],
      first_air_date: map['first_air_date'],
      last_air_date: map['last_air_date'],
      number_of_episodes: map['number_of_episodes'],
      number_of_seasons: map['number_of_seasons'],
      producers: map['production_companies'],
      seasons: map['seasons'],
        backdrop_path:map['backdrop_path']
    );
  }

  String toJson() => json.encode(toMap);

  factory tvdetails.fromJson(String source) =>
      tvdetails.fromMap(json.decode(source));
}
