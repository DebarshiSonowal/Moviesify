import 'package:flutter/material.dart';
import 'package:movieslist/Model/Producers.dart';
import 'package:movieslist/UI/Widgets/ProducerItem.dart';
import 'package:sizer/sizer.dart';
import '../../Constraints.dart';

class producer_section extends StatelessWidget {
  producer_section({Key key, this.title, this.producers}) : super(key: key);
  final String title;
  List<producer> producers;

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
              title,
              style: Constraints.DetailsSubtitleStyle,
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            color: Constraints.bg_color,
            height: 20.h,
            child: Center(
              child: ListView.builder(
                  itemCount: producers.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return producer_item(
                      current: producers[index],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
