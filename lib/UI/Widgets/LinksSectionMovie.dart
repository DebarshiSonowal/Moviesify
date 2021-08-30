import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constraints.dart';

class link_section_movie extends StatelessWidget {
  link_section_movie({Key key, this.title, this.link}) : super(key: key);
  final title, link;
  bool proof;

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
            height: 50,
            child: Center(
              child: ListView.builder(
                  itemCount: Constraints.linklistMovie.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => {
                        Dialogs.materialDialog(
                            msg: Constraints.disclaimer,
                            msgStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                            title: "Disclaimer",
                            color: Colors.white,
                            titleStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            context: context,
                            actions: [
                              IconsOutlineButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _launchInBrowser(getLink(
                                      Constraints.linklistMovie[index].link,
                                      link,
                                      Constraints.linklistMovie[index].name));
                                },
                                text: 'I understand',
                                iconData: FontAwesomeIcons.check,
                                textStyle: TextStyle(color: Colors.green),
                                iconColor: Colors.grey,
                              ),
                            ]),
                        // _launchInBrowser(getLink(Constraints.linklistMovie[index].link,link,Constraints.linklistMovie[index].name))
                      },
                      child: Card(
                        color: Colors.red,
                        elevation: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                          width: 100,
                          child: Center(
                              child: Text('Link ${index+1}',
                                  style:
                                      Constraints.DetailsProducerSmallStyle)),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  String getLink(String link, name, website) {
    List<String> list = name.toString().split(' ');
    switch (website) {
      case '123moviesgo':
        String fullname = list.join('+');
        link = link + fullname;
        return link;
      case 'gostream.site':
        String fullname = list.join('+');
        link = link + '?s=' + fullname.toLowerCase();
        return link;
      case 'solarmovie':
        String fullname = list.join('+');
        link = link + fullname + '.html';
        return link;
      case 'AZM':
        String fullname = list.join('-');
        link = link + fullname.toLowerCase();
        return link;
    }
  }
}

Future<void> _launchInBrowser(String url) async {
  print('current browser link is $url');
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  } else {
    throw 'Could not launch $url';
  }
}
