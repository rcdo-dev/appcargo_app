import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/endpoints.dart';
import 'package:app_cargo/screens/social_medias/widgets/social_media_button.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMedias extends StatefulWidget {
  const SocialMedias({
    Key key,
  }) : super(key: key);

  @override
  _SocialMediasState createState() => _SocialMediasState();
}

class _SocialMediasState extends State<SocialMedias> {
  final key = GlobalKey<ScaffoldState>();

  Future<void> openUrl({@required String url}) async {
    var address = url;
    if (await canLaunch(address)) {
      await launch(address);
    } else {
      appSnackbar(
        text:
            'Não foi possível acessar essa rede social.\nTente novamente mais tarde!',
      );
    }
  }

  void appSnackbar({@required String text}) {
    var snackbar = SnackBar(
      backgroundColor: AppColors.red,
      content: Text(
        text,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      ),
    );
    key.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 55,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: 100,
                    child: Image.asset(
                      "assets/images/logo.png",
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: AppText(
                    "REDES SOCIAIS",
                    fontSize: 20,
                    textColor: AppColors.grey,
                    weight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 125,
            ),
            Container(
              width: 300,
              height: 250,
              child: Column(
                children: <Widget>[
                  SocialMediaButton(
                    textButton: 'INSTAGRAM',
                    imageButton: 'assets/images/instagram_icon.png',
                    onPressed: () {
                      openUrl(
                        url: Endpoints.appInstagram,
                      );
                    },
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  SocialMediaButton(
                    textButton: 'TIK TOK',
                    imageButton: 'assets/images/tiktok_icon.png',
                    onPressed: () {
                      openUrl(
                        url: Endpoints.appTikTok,
                      );
                    },
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  SocialMediaButton(
                    textButton: 'FACEBOOK',
                    imageButton: 'assets/images/facebook_icon.png',
                    onPressed: () {
                      openUrl(
                        url: Endpoints
                            .appFacebook, //'https://www.instagram.com/appcargobr/',
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
