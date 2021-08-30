import 'dart:async';


import 'package:dio/dio.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:movieslist/Error/movies_exception.dart';
import 'package:movieslist/Model/Cast.dart';
import 'package:movieslist/Model/Creator.dart';
import 'package:movieslist/Model/Genres.dart';
import 'package:movieslist/Model/MediaProvider.dart';
import 'package:movieslist/Model/Movie.dart';
import 'package:movieslist/Model/MovieDetails.dart';
import 'package:movieslist/Model/Season.dart';
import 'package:movieslist/Model/TVShow.dart';
import 'package:movieslist/Model/TvDetails.dart';
import 'package:movieslist/enviroment_config.dart';

final movieServiceProvider = Provider<MovieService>((ref) {
  final config = ref.read(environmentConfig);

  return MovieService(config, Dio());
});

class MovieService {
  final EnvironmentConfig _enviroment_config;
  final Dio _dio;
  MovieService(this._enviroment_config, this._dio);

  Future<Map<String, dynamic>> getPopularMovies(int page) async {

    try {
      final response = await _dio.get(
          "https://api.themoviedb.org/3/movie/popular?api_key=${_enviroment_config.APIKey}&language=en-US&page=${page}");

      final results = List<Map<String, dynamic>>.from(response.data['results']);

      List<Movie> movies = results
          .map((movieData) => Movie.fromMap(movieData))
          .toList(growable: false);
      final responseGen = await _dio.get(
          "https://api.themoviedb.org/3/genre/movie/list?api_key=${_enviroment_config.APIKey}&language=en-US");

      final resultsGen =
          List<Map<String, dynamic>>.from(responseGen.data['genres']);

      List<Genres> genres = resultsGen
          .map((genresData) => Genres.fromMap(genresData))
          .toList(growable: false);
      return {
        'movies': movies,
        'genres': genres,
      };
    } on DioError catch (e) {
      print('error2 $e');
      throw MoviesException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> getMovieDetails(int id) async {
    print('The id is ${id}');
    try {
      final response = await _dio.get(
        'https://api.themoviedb.org/3/movie/${id}?api_key=${_enviroment_config.APIKey}&language=en-US');


      final results = Map<String, dynamic>.from(response.data);



      movie_details movieDetails = movie_details.fromMap(results);


      final responseGen = await _dio.get(
          "https://api.themoviedb.org/3/genre/movie/list?api_key=${_enviroment_config.APIKey}&language=en-US");

      final resultsGen =
      List<Map<String, dynamic>>.from(responseGen.data['genres']);

      List<Genres> genres = resultsGen
          .map((genresData) => Genres.fromMap(genresData))
          .toList(growable: false);



      List<media_provider> movieproviders;

      try {
        final responseProvider = await _dio.get(
                  "https://api.themoviedb.org/3/movie/${id}/watch/providers?api_key=${_enviroment_config.APIKey}");
        var responseFiltered;
        if(responseProvider.data['results']['US']!=null){
                responseFiltered = responseProvider.data['results']['US'];
              }
              else{
                responseFiltered = responseProvider.data['results']['IN'];
              }

        final resultsProvider =
              List<Map<String, dynamic>>.from(responseFiltered['buy']);


        movieproviders = resultsProvider
                  .map((movieData) => media_provider.fromMap(movieData))
                  .toList(growable: false);


      } catch (e) {
        print('My error ${e}');
        movieproviders=[];
      }


      final responseCast = await _dio.get(
          'https://api.themoviedb.org/3/movie/${id}/credits?api_key=${_enviroment_config.APIKey}&language=en-US');

      final resultsCast =  List<Map<String, dynamic>>.from(responseCast.data["cast"]);

      print('The result is ${responseCast.data["cast"]}');
      List<cast> movieCast
      = resultsCast
          .map((genresData) => cast.fromMap(genresData))
          .toList(growable: false);

      // movieCast=[];

      return {
        'movieData': movieDetails,
        'genres': genres,
        'providers':movieproviders,
        'cast':movieCast,
      };
    } on DioError catch (e) {
      print('error 1 $e');
      throw MoviesException.fromDioError(e);
    }
  }


  Future<Map<String, dynamic>> getTopRatedMovies(int page) async {

    try {
      final response = await _dio.get(
          "https://api.themoviedb.org/3/movie/top_rated?api_key=${_enviroment_config.APIKey}&language=en-US&page=${page}");

      final results = List<Map<String, dynamic>>.from(response.data['results']);



      List<Movie> movies = results
          .map((movieData) => Movie.fromMap(movieData))
          .toList(growable: false);
      final responseGen = await _dio.get(
          "https://api.themoviedb.org/3/genre/movie/list?api_key=${_enviroment_config.APIKey}&language=en-US");

      final resultsGen =
      List<Map<String, dynamic>>.from(responseGen.data['genres']);

      List<Genres> genres = resultsGen
          .map((genresData) => Genres.fromMap(genresData))
          .toList(growable: false);
      return {
        'movies': movies,
        'genres': genres,
      };
    } on DioError catch (e) {
      print('error4 $e');
      throw MoviesException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> getUpcomingMovies(int page) async {

    try {
      final response = await _dio.get(
          "https://api.themoviedb.org/3/movie/upcoming?api_key=${_enviroment_config.APIKey}&language=en-US&page=${page}");

      final results = List<Map<String, dynamic>>.from(response.data['results']);


      List<Movie> movies = results
          .map((movieData) => Movie.fromMap(movieData))
          .toList(growable: false);
      final responseGen = await _dio.get(
          "https://api.themoviedb.org/3/genre/movie/list?api_key=${_enviroment_config.APIKey}&language=en-US");

      final resultsGen =
      List<Map<String, dynamic>>.from(responseGen.data['genres']);

      List<Genres> genres = resultsGen
          .map((genresData) => Genres.fromMap(genresData))
          .toList(growable: false);
      return {
        'movies': movies,
        'genres': genres,
      };
    } on DioError catch (e) {
      print('error4 $e');
      throw MoviesException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> getPopularTvShows(int page) async {

    try {
      final response = await _dio.get(
          "https://api.themoviedb.org/3/tv/popular?api_key=${_enviroment_config.APIKey}&language=en-US&page=${page}");

      final results = List<Map<String, dynamic>>.from(response.data['results']);

      List<tvshow> tv_shows = results
          .map((movieData) => tvshow.fromMap(movieData))
          .toList(growable: false);
      final responseGen = await _dio.get(
          "https://api.themoviedb.org/3/genre/movie/list?api_key=${_enviroment_config.APIKey}&language=en-US");

      final resultsGen =
      List<Map<String, dynamic>>.from(responseGen.data['genres']);

      List<Genres> genres = resultsGen
          .map((genresData) => Genres.fromMap(genresData))
          .toList(growable: false);


      return {
        'tv': tv_shows,
        'genres': genres,
      };
    } on DioError catch (e) {
      print('error2 $e');
      throw MoviesException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> getTvDetails(int id) async {
    var responseFiltered;
    try {


      final response = await _dio.get(
          'https://api.themoviedb.org/3/tv/${id}?api_key=${_enviroment_config.APIKey}&language=en-US');

      final responseCast = await _dio.get(
          'https://api.themoviedb.org/3/tv/${id}/credits?api_key=${_enviroment_config.APIKey}&language=en-US');


      final responseGen = await _dio.get(
          "https://api.themoviedb.org/3/genre/movie/list?api_key=${_enviroment_config.APIKey}&language=en-US");


      final responseProvider = await _dio.get(
          "https://api.themoviedb.org/3/tv/${id}/watch/providers?api_key=${_enviroment_config.APIKey}");



      final results = Map<String, dynamic>.from(response.data);

      print('The answe ${results}');

      tvdetails tvDetails = tvdetails.fromMap(results);

      final resultsGen = List<Map<String, dynamic>>.from(responseGen.data['genres']);

      List<Genres> genres = resultsGen
          .map((genresData) => Genres.fromMap(genresData))
          .toList(growable: false);

      List<creator_model> creators =tvDetails.creator.map((creator) => creator_model.fromMap(creator)).toList(growable: false);

      List<season> seasons = tvDetails.seasons.map((Seasons) =>season.fromMap(Seasons)).toList(growable: false);

      List<media_provider> movieproviders;

      try {
        if (responseProvider.data['results']!=null) {
                if(responseProvider.data['results']['US']!=null){
                        responseFiltered = responseProvider.data['results']['US'];
                      }
                      else{
                        responseFiltered = responseProvider.data['results']['IN'];
                      }

                final resultsProvider =
                List<Map<String, dynamic>>.from(responseFiltered['buy']);


                movieproviders = resultsProvider
                    .map((movieData) => media_provider.fromMap(movieData))
                    .toList(growable: false);
              }else{

              }
      } catch (e) {
        print(e);
        movieproviders=[];
      }


      final resultsCast =  List<Map<String, dynamic>>.from(responseCast.data["cast"]);


      List<cast> movieCast
      = resultsCast
          .map((genresData) => cast.fromMap(genresData))
          .toList(growable: false);

      // movieCast=[];

      return {
        'tvData': tvDetails,
        'genres': genres,
        'providers':movieproviders,
        'cast':movieCast,
        'seasons':seasons,
        'creators':creators
      };
    } on DioError catch (e) {
      print('error 1 $e');
      throw MoviesException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> getMovieSearch(String query) async {
    print('query ${query}');
    try {
      final response = await _dio.get(
          "https://api.themoviedb.org/3/search/movie?api_key=${_enviroment_config.APIKey}&language=en-US&query=${query}&page=1&include_adult=false");
      //
      https://api.themoviedb.org/3/search/movie?api_key=<<api_key>>&language=en-US&page=1&include_adult=false
      final results = List<Map<String, dynamic>>.from(response.data['results']);

      List<Movie> searchedMovies = results
          .map((movieData) => Movie.fromMap(movieData))
          .toList(growable: false);
      print('query1 ${searchedMovies[0].title}');
      return {
        'result': searchedMovies,
      };
    } on DioError catch (e) {
      print('error2 $e');
      throw MoviesException.fromDioError(e);
    }
  }
  Future<Map<String, dynamic>> getTvSearch(String query) async {
    print('query ${query}');
    try {
      final response = await _dio.get(
          "https://api.themoviedb.org/3/search/tv?api_key=${_enviroment_config.APIKey}&language=en-US&query=${query}&page=1&include_adult=false");
      //https://api.themoviedb.org/3/search/tv?api_key=<<api_key>>&language=en-US&page=1&include_adult=false
      // https://api.themoviedb.org/3/search/movie?api_key=<<api_key>>&language=en-US&page=1&include_adult=false
      final results = List<Map<String, dynamic>>.from(response.data['results']);

      List<tvshow> tv_shows = results
          .map((movieData) => tvshow.fromMap(movieData))
          .toList(growable: false);
      print('query1 ${tv_shows[0].name}');
      return {
        'result': tv_shows,
      };
    } on DioError catch (e) {
      print('error2 $e');
      throw MoviesException.fromDioError(e);
    }
  }


}
