

import 'dart:convert';

class season{
  int id,season_no,total;
  String name,air_date,poster_path,overview;

  season(
      {this.id,
      this.season_no,
      this.total,
      this.name,
      this.air_date,
      this.poster_path,
      this.overview});

  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$poster_path';

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'poster_path': poster_path,
      'air_date': air_date,
      'season_no': season_no,
      'total':total,
      'overview':overview,
      'id': id
    };
  }

  factory season.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return season(
          name: '',
          poster_path: '',
          air_date: '',
          season_no: 0,
          total:0,
          overview:'',
          id: 1);
    }
    return season(
        name: map['name'],
        poster_path:map['poster_path'],
        air_date: map['air_date'],
        season_no: map['season_number'],
        total:map['episode_count'],
        overview:map['overview'],
        id: map['id']);
  }

  String toJson() => json.encode(toMap);

  factory season.fromJson(String source) => season.fromMap(json.decode(source));


}