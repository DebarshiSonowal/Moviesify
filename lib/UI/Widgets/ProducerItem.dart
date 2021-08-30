import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:movieslist/Model/Producers.dart';
import 'package:sizer/sizer.dart';
import '../../Constraints.dart';

class producer_item extends StatelessWidget {
  producer_item({Key key, this.current}) : super(key: key);
  final producer current;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Constraints.bg_color,
      elevation: 10,
      color: Constraints.bg_color,
      child: Container(
        padding: EdgeInsets.only(top: 2, bottom: 5),
        height: 13.h,
        color: Constraints.bg_color,
        width: 37.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: ClipOval(
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  width: 28.w,
                  height: 35.h,
                  imageUrl: current.fullImageUrl,
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
              flex: 1,
              child: Text(
                current.name,
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
