

import 'dart:convert';

import 'package:movieslist/Model/Producers.dart';


class movie_details{

  int id;
  String title,tagline,poster_path,backdrop_path,overview,original_language;
  dynamic vote_average,budget,homepage,revenue;
  bool adult;
  List<dynamic> genre_ids;
  List<dynamic> producers;

  movie_details(
      {this.id,
      this.title,
      this.tagline,
      this.poster_path,
      this.backdrop_path,
      this.overview,
      this.original_language,
      this.vote_average,
      this.budget,
      this.homepage,
      this.revenue,
      this.adult,
      this.genre_ids,this.producers});

  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$poster_path';

  String get fullImageBgUrl => 'https://image.tmdb.org/t/p/w200$backdrop_path';

  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'title':title,
      'tagline':tagline,
      'poster_path':poster_path,
      'backdrop_path':backdrop_path,
      'overview':overview,
      'original_language':original_language,
      'vote_average':vote_average,
      'budget':budget,
      'homepage':homepage,
      'revenue':revenue,
      'adult':adult,
      'genre_ids':genre_ids,
      'producers':producers,
    };
  }

factory movie_details.fromMap(Map <String, dynamic> map){
    if(map == null){
      return movie_details(
        id: 1,
        title:'',
        tagline: '',
          poster_path:'poster_path',
          backdrop_path:'backdrop_path',
          overview:'overview',
          original_language:'original_language',
          vote_average:1,
          budget:0,
          homepage:'homepage',
          revenue:0,
          adult:false,
          genre_ids:[],
          producers:[],
      );
    }
    return movie_details(
        id: map['id'],
        title: map['title'],
        tagline: map['tagline'],
        poster_path:map['poster_path'],
        backdrop_path:map['backdrop_path'],
        overview:map['overview'],
        original_language:map['original_language'],
        vote_average:map['vote_average'],
        budget:map['budget'],
        homepage:map['homepage'],
        revenue:map['revenue'],
        adult:map['adult'],
        genre_ids:map['genres'],
        producers:map['production_companies']
    );
}
  String toJson() => json.encode(toMap);

  factory movie_details.fromJson(String source) => movie_details.fromMap(json.decode(source));

}