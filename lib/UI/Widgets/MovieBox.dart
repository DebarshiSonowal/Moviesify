import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:movieslist/Model/Movie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'FrontBanner.dart';

class MovieBox extends StatelessWidget {
  final Movie movie;
  final String genres;

  const MovieBox({Key key, @required this.movie, @required this.genres})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: movie.fullImageUrl,
              placeholder: (context, s) {
                return  FadeShimmer(
                  height:double.infinity,
                  width: double.infinity,
                  radius: 4,
                  fadeTheme: FadeTheme.dark,
                  highlightColor: Color(0xffF9F9FB),
                  baseColor: Color(0xffE6E8EB),
                );
              },
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            movie.adult
                ? Card(
                    child: Container(
                      color: Colors.red,
                      child: Text(
                        '18+',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          top: 27.h,
          right: 0,
          child: FrontBaner(
              text: movie.title, rating: movie.vote_average, genres: genres),
        )
      ],
    );
  }
}
