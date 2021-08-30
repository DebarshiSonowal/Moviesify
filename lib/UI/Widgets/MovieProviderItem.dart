import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:movieslist/Model/MediaProvider.dart';
import 'package:sizer/sizer.dart';
import '../../Constraints.dart';

class movie_provider_item extends StatelessWidget {
  movie_provider_item({Key key, this.provider}) : super(key: key);
  final media_provider provider;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Constraints.bg_color,
      elevation: 10,
      color: Constraints.bg_color,
      child: Container(
        padding: EdgeInsets.only(top: 2, bottom: 5),
        height: 16.h,
        color: Constraints.bg_color,
        width: 28.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                width: 20.w,
                height: 18.h,
                imageUrl: provider.fullImageUrl,
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
            Flexible(
              flex: 1,
              child: Text(
                provider.name,
                style: Constraints.DetailsProducerSmallStyle,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
