import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fragment_navigate/navigate-bloc.dart';
import 'package:movieslist/Constraints.dart';
import 'package:movieslist/Model/DataSearch.dart';
import 'package:movieslist/Model/Genres.dart';
import 'package:movieslist/Model/Movie.dart';
import 'package:movieslist/Services/movie_services.dart';
import 'package:movieslist/UI/Screens/TopRated.dart';
import 'package:movieslist/UI/Screens/TvShows.dart';

import 'Screens/About.dart';
import 'Screens/Searching.dart';
import 'Screens/Upcoming.dart';
import 'Screens/Populars.dart';
import 'package:sizer/sizer.dart';

int i = 1;

final moviesFutureProvider =
    FutureProvider.autoDispose<List<Movie>>((ref) async {
  ref.maintainState = true;

  final movieService = ref.read(movieServiceProvider);
  final movies = await movieService.getPopularMovies(i <= 0 ? 1 : i);
  genres = movies['genres'];
  return movies['movies'];
});

List<Genres> genres;

class Home extends StatefulWidget {
  static int index = 0;
  static final _fragNav = FragNavigate(
    firstKey: 'popular',
    drawerContext: null,
    screens: <Posit>[
      Posit(
          key: 'popular',
          title: Constraints.popularText,
          fragment: popular(),
          icon: Constraints.popularIcon),
      Posit(
          key: 'top_rated',
          title: Constraints.topRatedText,
          fragment: top_rated(),
          icon: Constraints.topRatedIcon),
      Posit(
          key: 'upcoming',
          title: Constraints.upcomingText,
          fragment: upcoming(),
          icon: Constraints.upcomingIcon),
      Posit(
          key: 'tv_shows',
          title: Constraints.tvShowText,
          fragment: tv_shows(),
          icon: Constraints.tvShowIcon),
    ],
  );

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Home._fragNav.setDrawerContext = context;
    return WillPopScope(
      onWillPop: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit an App'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: new Text('No'),
                ),
                new FlatButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: new Text('Yes'),
                ),
              ],
            );
          },
        ).whenComplete(() => Future.value(false));
        return Future.delayed(Duration(seconds: 3), () {
          return Future.value(false);
        });
      },
      child: StreamBuilder<FullPosit>(
        stream: Home._fragNav.outStreamFragment,
        builder: (con, s) {
          if (s.data != null) {
            return Scaffold(
              key: Home._fragNav.drawerKey,
              appBar: AppBar(
                backgroundColor: Constraints.titleBarColor,
                title: Text(
                  getTitle(),
                  style: Constraints.TitleStyle,
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => about()));
                    },
                    icon: Icon(FontAwesomeIcons.info,size: 3.h,),
                  ),
                ],
                bottom: s.data.bottom.child,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  // showSearch(context: context,delegate: DataSearch());
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => searching()));
                },
                child: Container(
                  child: Center(
                    child: Icon(FontAwesomeIcons.search),
                  ),
                ),
              ),
              body: DefaultTabController(
                length: s.data.bottom.length,
                child:
                    ScreenNavigate(child: s.data.fragment, bloc: Home._fragNav),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Constraints.titleBarColor,
                iconSize: 25,
                selectedFontSize: 14,
                unselectedFontSize: 10,
                unselectedItemColor: Colors.white,
                unselectedLabelStyle: TextStyle(
                  color: Colors.white,
                ),
                enableFeedback: true,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Constraints.popularIcon,
                    ),
                    label: Constraints.popularTitle,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Constraints.topRatedIcon),
                    label: Constraints.topRatedTitle,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Constraints.upcomingIcon),
                    label: Constraints.upcomingTitle,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Constraints.tvShowIcon),
                    label: Constraints.tvShowTitle,
                  ),
                ],
                currentIndex: Home.index,
                onTap: (no) {
                  setState(() {
                    Home.index = no;
                    switchFragment(no, Home._fragNav);
                  });
                },
              ),
            );
          } else {
            return Container(
              color: Colors.grey,
              height: double.infinity,
              width: double.infinity,
            );
          }
        },
      ),
    );
  }

  void switchFragment(int no, _fragNavigate) {
    switch (no) {
      case 0:
        _fragNavigate.putPosit(key: 'popular', force: true);
        break;
      case 1:
        _fragNavigate.putPosit(key: 'top_rated', force: true);
        break;
      case 2:
        _fragNavigate.putPosit(key: 'upcoming', force: true);
        break;
      case 3:
        _fragNavigate.putPosit(key: 'tv_shows', force: true);
        break;
    }
  }

  getTitle() {
    switch (Home._fragNav.currentKey) {
      case 'popular':
        return Constraints.popularText;
        break;
      case 'top_rated':
        return Constraints.topRatedText;
        break;
      case 'upcoming':
        return Constraints.upcomingText;
        break;
      case 'tv_shows':
        return Constraints.tvShowText;
        break;
    }
  }
}
