import 'dart:ui';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Model/MovieLink.dart';

class Constraints {
  static final titleBarColor = Color(0xff212121);
  static final bg_color = Color(0xff303030);

  static final titleText = 'Movies';
  static final TitleStyle = TextStyle(
    color: Colors.red,
    fontFamily: 'BioRhyme',
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );

  static final textTitleStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'BioRhyme',
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
  );
  static final textSubtitleStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'BioRhyme',
    fontSize: 8.sp,
  );

  //Movie Details
  static final DetailsTitleStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'BioRhyme',
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );
  static final DetailsSubtitleStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'BioRhyme',
    fontSize: 14.sp,
  );

  static final DetailsSmallStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'BioRhyme',
    fontSize: 10.sp,
  );

  static final DetailsNumberStyle = TextStyle(
    color: Colors.red,
    fontFamily: 'BioRhyme',
    fontSize: 10.sp,
  );

  static final DetailsMoneyStyle = TextStyle(
    color: Colors.green,
    fontFamily: 'BioRhyme',
    fontSize: 10.sp,
  );
  static final DetailsExtraSmallStyle = TextStyle(
    color: Colors.red,
    fontFamily: 'BioRhyme',
    fontSize: 8.sp,
  );
  static final DetailsProducerSmallStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'BioRhyme',
    fontSize: 8.sp,
  );

  static final ErrorTextStyle = TextStyle(
    color: Colors.red,
    fontFamily: 'BioRhyme',
    fontSize: 14.sp,
  );

  //Popularity
  static final popularText = 'Popular Movies';
  static final popularTitle = 'Popular';
  static final popularIcon = FontAwesomeIcons.star;

  //Top Rated
  static final topRatedText = 'Top Rated Movies';
  static final topRatedTitle = 'Top Rated';
  static final topRatedIcon = FontAwesomeIcons.fire;

  //Latest
  static final upcomingText = 'Upcoming Movies';
  static final upcomingTitle = 'Upcoming';
  static final upcomingIcon = FontAwesomeIcons.calendar;

  //TV Show
  static final tvShowText = 'Tv Show';
  static final tvShowTitle = 'Tv Show';
  static final tvShowIcon = FontAwesomeIcons.tv;

  static int id = 436969;
  static String query = '';

  //
  static final linklistMovie = [
    movieLink(name: 'AZM', link: 'https://azm.to/movie/'),
    movieLink(name: 'solarmovie', link: 'https://www2.solarmovie.to/search/'),
    movieLink(
      name: 'gostream.site',
      link: 'https://gostream.site/',
    ),
    movieLink(name: '123moviesgo', link: 'https://123moviesgo.ga/search/'),
  ];

  static final linklistTv = [
    movieLink(name: 'Noxx', link: 'https://noxx.is/tv/'),
    movieLink(name: 'solarmovie', link: 'https://www2.solarmovie.to/search/'),
    movieLink(name: 'moviestars', link: 'https://moviestars.to/search/'),
    movieLink(name: 'fmovies', link: 'https://fmoviesto.cc/search/'),
  ];

  static final disclaimer =
      'I am neither promoting nor encouraging anyone to do or watch piracy. I neither own these websites nor there content. So watch it with your own risk.';

  static final social_list = [
    FontAwesomeIcons.facebook,
    FontAwesomeIcons.twitter,
    FontAwesomeIcons.instagram,
    FontAwesomeIcons.linkedin,
    FontAwesomeIcons.github,
    FontAwesomeIcons.chrome,
  ];
  static final social_list_link = [
    'https://www.facebook.com/debarkhi.sonowal/',
    'https://twitter.com/Iamdebarkhi',
    'https://www.instagram.com/debarshi_sonowal/',
    'www.linkedin.com/in/debarshisonowal',
    'https://github.com/DebarshiSonowal',
    'https://elastic-yalow-dd69dc.netlify.app/'
  ];
}
