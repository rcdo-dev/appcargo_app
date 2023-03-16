import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/whatsapp_constants.dart';
import 'package:app_cargo/screens/financing/widgets/app_omni_menu_option_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OmniMenuOptions extends StatefulWidget {
  @override
  _OmniMenuOptionsState createState() => _OmniMenuOptionsState();
}

class _OmniMenuOptionsState extends State<OmniMenuOptions> {
  final key = GlobalKey<ScaffoldState>();

  void appSnackbar({@required String text}) {
    var snackbar = SnackBar(
      backgroundColor: AppColors.red,
      content: Text(
        text,
        textAlign: TextAlign.center,
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: key,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/logo_omni.png',
                  width: size.width / 1.6,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Conectado com você!',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                    color: AppColors.light_blue,
                  ),
                ),
              ],
            ),
            Text(
              'Do primeiro caminhão\nao próximo bruto!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 24.0,
                fontWeight: FontWeight.w800,
                color: AppColors.dark_grey02,
              ),
            ),
            Text(
              'Conte com o\nfinanciamento Omni.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 24.0,
                fontWeight: FontWeight.w800,
                color: AppColors.dark_grey02,
              ),
            ),
            Column(
              children: <Widget>[
                AppOmniMenuOptionButton(
                  onPressedCallback: () async {
                    String phone = WhatsappConstants.numberWithCountryDDD;
                    var whatsappUrl = "whatsapp://send?phone=$phone&text=${WhatsappConstants.omniFinancingOptionMessage}";
                    if (await canLaunch(whatsappUrl)) {
                      await launch(whatsappUrl);
                    } else {
                      appSnackbar(
                        text: 'Instale o WHATSAPP para falar sobre financiamento!',
                      );
                    }
                  },
                  textButton: "Financiamento",
                  textButtonSize: 26.0,
                  buttonColor: Colors.orange[700],
                ),
                SizedBox(
                  height: size.height / 54,
                ),
                AppOmniMenuOptionButton(
                  onPressedCallback: () async {
                    String phone = WhatsappConstants.numberWithCountryDDD;
                    var whatsappUrl = "whatsapp://send?phone=$phone&text=${WhatsappConstants.omniRefinancingOptionMessage}";
                    if (await canLaunch(whatsappUrl)) {
                      await launch(whatsappUrl);
                    } else {
                      appSnackbar(
                        text: 'Instale o WHATSAPP para falar sobre refinanciamento!',
                      );
                    }
                  },
                  textButton: "Refinanciamento",
                  textButtonSize: 26.0,
                  buttonColor: Colors.blue[900],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
