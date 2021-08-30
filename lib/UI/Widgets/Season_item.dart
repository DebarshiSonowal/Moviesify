import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:movieslist/Model/Season.dart';
import 'package:sizer/sizer.dart';
import '../../Constraints.dart';

class season_item extends StatelessWidget {
  season_item({Key key, this.seasons}) : super(key: key);

  final season seasons;

  @override
  Widget build(BuildContext context) {
    print('url is ${seasons.name.toString()}');
    return GestureDetector(
      onTap:()=>{
        Dialogs.materialDialog(
            msg: seasons.overview==null||seasons.overview==''?'Not Available':seasons.overview,
            msgStyle: TextStyle(
              color: Colors.black,
              fontSize: 13,
            ),
            title:seasons.name,
            color: Colors.white,
            titleStyle: TextStyle(
              fontSize: 18,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
            context: context,),
      },
      child: Card(
        shadowColor: Constraints.bg_color,
        elevation: 10,
        color: Constraints.bg_color,
        child: Container(
          padding: EdgeInsets.only(top: 2, bottom: 5),
          height: 19.h,
          color: Constraints.bg_color,
          width: 23.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 5,
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  width: 150,
                  height: 20.h,
                  imageUrl: seasons.fullImageUrl,
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
                  seasons.name,
                  style: Constraints.DetailsSubtitleStyle,
                  textAlign: TextAlign.start,
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                 '${seasons.overview}',
                  style: Constraints.DetailsProducerSmallStyle,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
