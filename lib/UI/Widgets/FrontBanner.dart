import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:movieslist/Constraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

class FrontBaner extends StatelessWidget {
  FrontBaner(
      {Key key,
      @required this.text,
      @required this.rating,
      @required this.genres})
      : super(key: key);
  final String text, genres;
  final dynamic rating;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          color: Colors.grey.shade200.withOpacity(0.5),
          height: 30.h,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 2,
                  child: Text(
                    text,
                    style: Constraints.textTitleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  genres,
                  style: Constraints.textSubtitleStyle,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                Flexible(
                  child: RatingBar.builder(
                    itemSize: 20,
                    initialRating: rating is int
                        ? double.parse((rating / 2).toString())
                        : rating / 2,
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
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
