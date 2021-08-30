import 'package:flutter/material.dart';
import 'package:movieslist/Model/Season.dart';
import 'package:sizer/sizer.dart';
import '../../Constraints.dart';
import 'Season_item.dart';

class seasons_section extends StatelessWidget {
  seasons_section({Key key, this.seasons}) : super(key: key);
  final List<season> seasons;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Seasons',
              style: Constraints.DetailsSubtitleStyle,
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            color: Constraints.bg_color,
            height: 30.h,
            child: Center(
              child: ListView.builder(
                  itemCount: seasons.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return season_item(
                      seasons: seasons[index],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
