import 'package:flutter/material.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';
import 'package:sizer/sizer.dart';

import 'UI/Home.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: SplashScreen.navigate(
          name: 'assets/Animation/screenintro.riv',
          next: (context) => Home(),
          until: () => Future.delayed(Duration(seconds: 4)),
          startAnimation: 'Full Loop',
        ),
      );
    });
  }
}
