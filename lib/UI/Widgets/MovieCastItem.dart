import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:movieslist/Model/Cast.dart';
import 'package:sizer/sizer.dart';
import '../../Constraints.dart';

class movie_cast_item extends StatelessWidget {
movie_cast_item({Key key, this.casts}) : super(key: key);

final cast casts;

@override
Widget build(BuildContext context) {
  return Card(
    shadowColor: Constraints.bg_color,
    elevation: 10,
    color: Constraints.bg_color,
    child: Container(
      padding: EdgeInsets.only(top: 2, bottom: 5),
      height: 10.h,
      color: Constraints.bg_color,
      width: 45.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 8,
            child: ClipOval(
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                width: 40.w,
                height: 25.h,
                imageUrl: casts.fullImageUrl,
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
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Text(
              casts.name,
              style: Constraints.DetailsSubtitleStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Flexible(
            flex: 2,
            child: Text(
              casts.character==null?'':casts.character,
              style: Constraints.DetailsProducerSmallStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
}
