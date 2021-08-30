
import 'package:flutter/material.dart';
import 'package:movieslist/Model/MediaProvider.dart';
import 'package:movieslist/UI/Widgets/MovieProviderItem.dart';
import 'package:sizer/sizer.dart';
import '../../Constraints.dart';

class movie_provider_section extends StatelessWidget {
  movie_provider_section({Key key, this.title, this.providers}) : super(key: key);
  final String title;
  final List<media_provider> providers;
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
            height: 16.h,
            child: Center(
              child: ListView.builder(
                  itemCount: providers.length,
                  scrollDirection:
                  Axis.horizontal,
                  itemBuilder: (context, index) {
                    return movie_provider_item(provider: providers[index],);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
