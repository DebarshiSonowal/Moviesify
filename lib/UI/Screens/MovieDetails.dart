import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:movieslist/Constraints.dart';
import 'package:movieslist/Error/movies_exception.dart';
import 'package:movieslist/Model/Cast.dart';
import 'package:movieslist/Model/Genres.dart';
import 'package:movieslist/Model/MediaProvider.dart';
import 'package:movieslist/Model/MovieDetails.dart';
import 'package:movieslist/Model/Producers.dart';
import 'package:movieslist/Services/movie_services.dart';
import 'package:movieslist/UI/Widgets/LinksSectionMovie.dart';
import 'package:movieslist/UI/Widgets/MovieCastSection.dart';
import 'package:movieslist/UI/Widgets/MovieProviderSection.dart';
import 'package:movieslist/UI/Widgets/ProducerSection.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'Populars.dart';

List<Genres> genres;
List<media_provider> providers;
List<cast> casts;

final moviesFutureProvider =
    FutureProvider.autoDispose<movie_details>((ref) async {
  ref.maintainState = true;

  final movieService = ref.read(movieServiceProvider);
  final movies = await movieService.getMovieDetails(Constraints.id);
  genres = movies['genres'];
  providers = movies['providers'];
  casts = movies['cast'];
  return movies['movieData'];
});

final ratingbar = RatingBar.builder(
  itemSize: 20,
  initialRating: 2,
  minRating: 1,
  direction: Axis.horizontal,
  allowHalfRating: true,
  itemCount: 5,
  itemBuilder: (context, _) => Icon(
    Icons.star,
    color: Colors.amber,
  ),
  ignoreGestures: true,
  onRatingUpdate: (double value) {},
);

class MovieInfo extends ConsumerWidget {
  static int id = Constraints.id;
  static bool enabled = true;

  List<producer> producers = [];

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    if (id != Constraints.id) {
      context.refresh(moviesFutureProvider);
      id = Constraints.id;
    }
    return Material(
      child: Container(
        color: Constraints.bg_color,
        width: double.infinity,
        height: double.infinity,
        child: watch(moviesFutureProvider).when(
            data: (moviedata) {
              producers =
                  moviedata.producers.map((e) => producer.fromMap(e)).toList();
              return Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  SingleChildScrollView(
                    child: Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 25.h,
                              child: ShapeOfView(
                                shape: ArcShape(
                                    direction: ArcDirection.Outside,
                                    height: 20,
                                    position: ArcPosition.Bottom),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: moviedata.fullImageBgUrl,
                                  filterQuality: FilterQuality.high,
                                  placeholder: (context, s) {
                                    return FadeShimmer(
                                      height: double.infinity,
                                      width: double.infinity,
                                      radius: 4,
                                      fadeTheme: FadeTheme.dark,
                                      highlightColor: Color(0xffF9F9FB),
                                      baseColor: Color(0xffE6E8EB),
                                    );
                                  },
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            Container(
                              color: Constraints.bg_color,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left:45.w),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          moviedata.title,
                                          style: Constraints.DetailsTitleStyle,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      moviedata.vote_average
                                                          .toString(),
                                                      style: Constraints
                                                          .DetailsNumberStyle,
                                                    ),
                                                    Text(
                                                      'rating',
                                                      style: Constraints
                                                          .DetailsSmallStyle,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  child: RatingBar.builder(
                                                    itemSize: 15,
                                                    initialRating:
                                                        moviedata.vote_average,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 10,
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    ignoreGestures: true,
                                                    onRatingUpdate:
                                                        (double value) {},
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Budget',
                                                style: Constraints
                                                    .DetailsSmallStyle,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                moviedata.budget == 0
                                                    ? 'Not Available'
                                                    : '${moviedata.budget} \$',
                                                style: Constraints
                                                    .DetailsMoneyStyle,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Revenue',
                                                style: Constraints
                                                    .DetailsSmallStyle,
                                              ),
                                              SizedBox(
                                                width: 8.w,
                                              ),
                                              Text(
                                                moviedata.revenue == 0
                                                    ? 'Not Available'
                                                    : '${moviedata.revenue} \$',
                                                style: Constraints
                                                    .DetailsMoneyStyle,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Genres',
                                            style: Constraints
                                                .DetailsSubtitleStyle,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              '${getGenresDetails(moviedata)}',
                                              style:
                                                  Constraints.DetailsSmallStyle,
                                              overflow: TextOverflow.clip),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ExpandablePanel(
                                            theme: ExpandableThemeData(
                                              iconColor: Colors.white,
                                            ),
                                            header: Text(
                                              'Story',
                                              style: Constraints
                                                  .DetailsSubtitleStyle,
                                            ),
                                            collapsed: Text(
                                              moviedata.overview.toString(),
                                              style:
                                                  Constraints.DetailsSmallStyle,
                                              softWrap: true,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            expanded: Text(
                                              moviedata.overview.toString(),
                                              style:
                                                  Constraints.DetailsSmallStyle,
                                              softWrap: true,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  link_section_movie(
                                    title: 'Links',
                                    link: moviedata.title,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  producers.length > 0
                                      ? producer_section(
                                          title: 'Producers',
                                          producers: producers,
                                        )
                                      : Container(),
                                  providers.length > 0
                                      ? movie_provider_section(
                                          title: 'Where to watch',
                                          providers: providers,
                                        )
                                      : Container(),
                                  casts.length > 0
                                      ? movie_cast_section(
                                          casts: casts,
                                          title: 'Cast',
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Card(
                          margin: EdgeInsets.only(top: 150, left: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          child: Container(
                            child: CachedNetworkImage(
                              height: 190,
                              width: 135,
                              fit: BoxFit.fill,
                              imageUrl: moviedata.fullImageUrl,
                              placeholder: (context, s) {
                                return FadeShimmer(
                                  height: double.infinity,
                                  width: double.infinity,
                                  radius: 4,
                                  fadeTheme: FadeTheme.dark,
                                  highlightColor: Color(0xffF9F9FB),
                                  baseColor: Color(0xffE6E8EB),
                                );
                              },
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: IconButton(
                      splashColor: Colors.white,
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
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
                return errorwidget(message: '$e');
              }
              print('Error ${e}');
              return errorwidget(
                  message: 'Oops! something unexpected occurred');
            }),
      ),
    );
  }

  getGenresDetails(movie_details moviedata) {
    final String genresIDs = moviedata.genre_ids.toString();
    List<Genres> genresId =
        moviedata.genre_ids.map((e) => Genres.fromMap(e)).toList();
    print(genresIDs);
    String result = '';
    for (var i in genresId) {
      for (var j in genres) {
        if (j.id == i.id) {
          result = result + j.name + ',';
        }
      }
    }
    return result.substring(0, result.length - 1);
  }
}
