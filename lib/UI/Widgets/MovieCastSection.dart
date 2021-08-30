import 'package:flutter/material.dart';
import 'package:movieslist/Model/Cast.dart';
import 'package:sizer/sizer.dart';
import '../../Constraints.dart';
import 'MovieCastItem.dart';

class movie_cast_section extends StatelessWidget {
  movie_cast_section({Key key, this.title, this.casts}) : super(key: key);
final String title;
final List<cast> casts;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Constraints
                  .DetailsSubtitleStyle,
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            color: Constraints.bg_color,
            height: 40.h,
            child: Center(
              child: ListView.builder(
                  itemCount: casts.length,
                  scrollDirection:
                  Axis.horizontal,
                  itemBuilder: (context, index) {
                    return movie_cast_item(casts:casts[index],);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
