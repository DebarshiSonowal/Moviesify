

import 'package:flutter/material.dart';
import 'package:movieslist/UI/Screens/Results.dart';

import '../Constraints.dart';



class DataSearch extends SearchDelegate{
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print('results ${query}');
    return query!=''?search_results(query):Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print('suggest ${query}');
    return query!=''?search_results(query):Container();
  }
  
}