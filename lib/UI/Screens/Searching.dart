import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:movieslist/Model/Movie.dart';
import 'package:movieslist/Model/TVShow.dart';
import 'package:movieslist/Services/movie_services.dart';
import 'package:sizer/sizer.dart';
import '../../Constraints.dart';
import 'MovieDetails.dart';
import 'TvShowDetails.dart';

final moviesFutureProvider =
    FutureProvider.autoDispose<List<Movie>>((ref) async {
  ref.maintainState = false;

  final movieService = ref.read(movieServiceProvider);
  final movies = await movieService.getMovieSearch(Constraints.query);
  return movies['result'];
});
final tvFutureProvider = FutureProvider.autoDispose<List<tvshow>>((ref) async {
  ref.maintainState = false;

  final movieService = ref.read(movieServiceProvider);
  final movies = await movieService.getTvSearch(Constraints.query);
  return movies['result'];
});

class searching extends ConsumerWidget {
  TextEditingController controller;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: Icon(Icons.search),
              title: TextField(
                controller: controller,
                cursorColor: Colors.white,
                onChanged: (query) {
                  context.refresh(moviesFutureProvider);
                  context.refresh(tvFutureProvider);
                  setState(() => {Constraints.query = query});
                },
                onSubmitted: (query) {
                  setState(() => {
                        Constraints.query = query,
                        context.refresh(moviesFutureProvider),
                        context.refresh(tvFutureProvider),
                      });
                },
                style: TextStyle(color: Colors.white),
              ),
              bottom: TabBar(tabs: [
                Tab(icon: Icon(Icons.movie)),
                Tab(icon: Icon(Icons.tv)),
              ]),
            ),
            body: TabBarView(children: [
              Constraints.query != ''
                  ? watch(moviesFutureProvider).when(
                      data: (data) {
                        return data.length > 0
                            ? ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text('${data[index].title}'),
                                    leading: CachedNetworkImage(
                                      height: 55.h,
                                      width: 15.w,
                                      fit: BoxFit.fill,
                                      imageUrl: data[index].fullImageUrl,
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
                                    onTap: () {
                                      Constraints.id = data[index].id;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieInfo()));
                                    },
                                  );
                                })
                            : Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: Center(
                                  child: Text(
                                    'No Results found',
                                    style: Constraints.ErrorTextStyle,
                                  ),
                                ),
                              );
                      },
                      loading: () => Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Center(child: CircularProgressIndicator())),
                      error: (e, s) => Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: GestureDetector(
                                onTap: () =>
                                    context.refresh(moviesFutureProvider),
                                child: Text(
                                  'Unable to load',
                                  style: Constraints.ErrorTextStyle,
                                )),
                          ))
                  : Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                          child: Text(
                        'Type a movie name',
                        style: Constraints.ErrorTextStyle,
                      )),
                    ),
              Constraints.query != ''
                  ? watch(tvFutureProvider).when(
                      data: (data) {
                        return data.length > 0
                            ? ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text('${data[index].name}'),
                                    leading: CachedNetworkImage(
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.fill,
                                      imageUrl: data[index].fullImageUrl,
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
                                    onTap: () {
                                      Constraints.id = data[index].id;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  tv_show_details()));
                                    },
                                  );
                                })
                            : Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: Center(
                                  child: Text(
                                    'No Results found',
                                    style: Constraints.ErrorTextStyle,
                                  ),
                                ),
                              );
                      },
                      loading: () => Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Center(child: CircularProgressIndicator())),
                      error: (e, s) => Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: GestureDetector(
                                onTap: () =>
                                    context.refresh(moviesFutureProvider),
                                child: Text(
                                  'Not Found',
                                  style: Constraints.ErrorTextStyle,
                                )),
                          ))
                  : Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                          child: Text(
                        'Type a tvshow name',
                        style: Constraints.ErrorTextStyle,
                      )),
                    )
            ]),
          ),
        );
      },
    );
  }
}
