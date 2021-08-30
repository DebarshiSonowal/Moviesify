import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieslist/Model/Result.dart';
import 'package:movieslist/Services/movie_services.dart';

import '../../Constraints.dart';

final moviesFutureProvider =
    FutureProvider.autoDispose<List<result>>((ref) async {
  ref.maintainState = false;

  final movieService = ref.read(movieServiceProvider);
  final movies = await movieService.getMovieSearch(Constraints.query);
  return movies['result'];
});

class search_results extends ConsumerWidget {
  String line;

  search_results(this.line);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    if (Constraints.query != line) {
      Constraints.query = line;
      context.refresh(moviesFutureProvider);
    }
    return watch(moviesFutureProvider).when(
        data: (data) {
          return data.length > 0
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('${data[index].name}'),
                      leading: Icon(
                        Icons.movie,
                      ),
                      onTap: (){

                      },
                    );
                  })
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      'No Results found',
                      style: Constraints.DetailsNumberStyle,
                    ),
                  ),
                );
        },
        loading: () => Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(child: CircularProgressIndicator())),
        error: (e, s) => Container(
              child: GestureDetector(
                  onTap: () => context.refresh(moviesFutureProvider),
                  child: Text(
                    'Unable to load',
                    style: Constraints.DetailsNumberStyle,
                  )),
            ));
  }
}
