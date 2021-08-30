import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieslist/Constraints.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class about extends StatelessWidget {
  const about({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constraints.bg_color,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/Image/playstore.png',
                      height: 20.h,
                      width: 20.h,
                    ),
                  ),
                  Text(
                    'Moviesify',
                    style: Constraints.TitleStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Text(
                'This is a hobby project and made just to showcase my skills and also to provide entertainment to its users.'
                'I am not responsible for what the useres do with this app. I have provided sufficient warning at required places'
                '.Enjoy the app.',
                style: Constraints.DetailsSubtitleStyle,
                textAlign: TextAlign.center,
              ),
              Text(
                'From \n Debarshi Sonowal \n',
                style: Constraints.DetailsSubtitleStyle,
                textAlign: TextAlign.center,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 5.h,
                    onPressed: (){
                      _sendemail();
                    },
                    icon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'For any problem click the above button',
                    style: Constraints.DetailsSmallStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Container(
                  height: 10.h,
                  width: double.infinity,
                  child: Center(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: Constraints.social_list.length,
                        itemBuilder: (context, index) {
                          return IconButton(
                            onPressed: () {
                              getFunction(
                                  index, Constraints.social_list_link[index]);
                            },
                            icon: Icon(
                              Constraints.social_list[index],
                              color: Colors.white,
                            ),
                          );
                        }),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void getFunction(int index, String link) {
    switch (index) {
      case 0:
        _launchSocial(link, link);
        break;
      default:
        _launchURL(link);
        break;
    }
  }
}

void _sendemail() async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: 'debarkhisonowal@gmail.com',
  );
  String url = params.toString();
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
  }
}

void _launchURL(String txt) async {
  var url = Uri.encodeFull(txt);
  // var url = Uri.encodeComponent(urls);
  try {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    await launch(url, forceSafariVC: false, forceWebView: false);
  }
}

void _launchSocial(String url, String fallbackUrl) async {
  // Don't use canLaunch because of fbProtocolUrl (fb://)
  try {
    bool launched =
        await launch(url, forceSafariVC: false, forceWebView: false);
    if (!launched) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  } catch (e) {
    await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
  }
}
