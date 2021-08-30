
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:movieslist/Model/TVShow.dart';
import 'package:sizer/sizer.dart';
import 'FrontBanner.dart';

class tvbox extends StatelessWidget {
  tvbox({Key key, this.tv, this.genres}) : super(key: key);
  final tvshow tv;
  final String genres;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: tv.fullImageUrl,
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
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          top: 27.h,
          right: 0,
          child: FrontBaner(
              text: tv.name, rating: tv.vote_average, genres: genres),
        )
      ],
    );
  }
}
