
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:movieslist/Error/movies_exception.dart';
import 'package:movieslist/Model/Genres.dart';
import 'package:movieslist/Model/Movie.dart';
import 'package:movieslist/Services/movie_services.dart';
import 'package:movieslist/UI/Widgets/MovieBox.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../../Constraints.dart';
import 'MovieDetails.dart';
import 'Populars.dart';


  int i = 1;

  final moviesFutureProvider =
  FutureProvider.autoDispose<List<Movie>>((ref) async {
    ref.maintainState = true;

    final movieService = ref.read(movieServiceProvider);
    final movies = await movieService.getTopRatedMovies(i <= 0 ? 1 : i);
    genres = movies['genres'];
    return movies['movies'];
  });

  List<Genres> genres;

class top_rated extends ConsumerWidget{

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    return Container(
      color: Constraints.bg_color,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: watch(moviesFutureProvider).when(
                data: (movies) {
                  return Scaffold(
                    backgroundColor: Constraints.bg_color,
                    body: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: WaterDropHeader(),
                      footer: CustomFooter(
                        builder: (BuildContext context, LoadStatus mode) {
                          Widget body;
                          if (mode == LoadStatus.idle) {
                            body = Text("pull up load");
                          } else if (mode == LoadStatus.loading) {
                            body = CupertinoActivityIndicator();
                          } else if (mode == LoadStatus.failed) {
                            body = Text("Load Failed!Click retry!");
                          } else if (mode == LoadStatus.canLoading) {
                            body = Text("release to load more");
                          } else {
                            body = Text("No more Data");
                          }
                          return Container(
                            height: 75.0,
                            child: Center(child: body),
                          );
                        },
                      ),
                      controller: _refreshController,
                      child: GridView.extent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.6,
                        shrinkWrap: true,
                        children: movies
                            .map((movie) => GestureDetector(
                            onTap: () => {
                              Constraints.id = movie.id,
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MovieInfo()))
                            },
                            child: MovieBox(
                                movie: movie, genres: getGenres(movie))))
                            .toList(),
                      ),
                      onRefresh: () {
                        if (i != 1) {
                          i--;
                        }
                        context.refresh(moviesFutureProvider);
                        _refreshController.refreshCompleted();
                      },
                      onLoading: () {
                        i++;
                        context.refresh(moviesFutureProvider);
                        _refreshController.loadComplete();
                      },
                    ),
                  );
                },
                loading: () => Center(
                  child: Shimmer.fromColors(
                    baseColor: Colors.red,
                    highlightColor: Colors.yellow,
                    enabled: true,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Fetching your favourite movies ....',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                error: (e, s) {
                  if (e is MoviesException) {
                    return errorwidget(message: e.message);
                  }
                  print('Error ${e}');
                  return errorwidget(
                      message: 'Oops! something unexpected occurred');
                }),
          ),
        ],
      ),
    );
  }

  getGenres(Movie movie) {
    final String genresIDs = movie.genre_ids.toString();
    String result = '';
    for (var i in movie.genre_ids) {
      for (var j in genres) {
        if (j.id == i) {
          result = result + j.name + ',';
        }
      }
    }
    return result.substring(0, result.length - 1);
  }

}
