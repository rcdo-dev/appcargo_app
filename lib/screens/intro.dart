import 'package:app_cargo/constants/analytics_events_constants.dart';
import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/routes.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  List<Slide> slides;

  final FacebookAppEvents _facebookAppEvents =
      DIContainer().get<FacebookAppEvents>();

  final FirebaseAnalytics _firebaseAnalytics =
      DIContainer().get<FirebaseAnalytics>();

  @override
  void initState() {
    super.initState();
    _firebaseAnalytics.setCurrentScreen(
        screenName: AnalyticsEventsConstants.tutorial);
  }

  void onDonePress() {
    Navigator.popAndPushNamed(context, Routes.index);
    _facebookAppEvents.logEvent(
        name: AnalyticsEventsConstants.tutorialComplete,
        parameters: {
          AnalyticsEventsConstants.action: AnalyticsEventsConstants.buttonClick
        });

    _firebaseAnalytics.logEvent(
        name: AnalyticsEventsConstants.tutorialComplete,
        parameters: {
          AnalyticsEventsConstants.action: AnalyticsEventsConstants.buttonClick
        });
  }

  List<Slide> buildSlides(double imageHeight) {
    if (null != slides) return slides;
    slides = List();
    slides.add(
      new Slide(
        title: "CRIE SUA CONTA",
        description:
            "Crie sua conta em poucos segundos. Informe os seus dados pessoais e do seu caminhão. É rápido e fácil!",
        pathImage: "assets/intro_images/step1.png",
        backgroundColor: AppColors.green,
        heightImage: imageHeight,
      ),
    );
    slides.add(
      new Slide(
        title: "ATUALIZE SEU STATUS",
        description:
            "Informe, diariamente, se está com carga, descarregado ou descarregando, para as transportadoras poderem encontrar seu caminhão.",
        pathImage: "assets/intro_images/step2.png",
        backgroundColor: AppColors.yellow,
        heightImage: imageHeight,
      ),
    );
    slides.add(
      new Slide(
        title: "SEU FRETE CHEGARÁ",
        description:
            "Você não precisa ficar verificando, mantenha o aplicativo instalado e, quando aparecer um frete para seu tipo de caminhão e localização, você será avisado.",
        pathImage: "assets/intro_images/step3.png",
        backgroundColor: AppColors.blue,
        heightImage: imageHeight,
      ),
    );
    slides.add(
      new Slide(
        title: "COMUNICAÇÃO FÁCIL",
        description:
            "Comunique-se conosco e com as transportadoras que te enviarem oferta pelo ZapCargo, um aplicativo de comunicação feito para você.",
        pathImage: "assets/intro_images/step4.png",
        backgroundColor: AppColors.green,
        heightImage: imageHeight,
      ),
    );
    return slides;
  }

  @override
  Widget build(BuildContext context) {
    double imageHeight = MediaQuery.of(context).size.height;
    imageHeight = imageHeight - (imageHeight * 0.6);

    return IntroSlider(
      slides: this.buildSlides(imageHeight),
      onDonePress: this.onDonePress,
      nameDoneBtn: "Comecar",
      nameSkipBtn: "Pular",
      nameNextBtn: "Próximo",
      colorDot: AppColors.white,
      colorActiveDot: AppColors.black,
    );
  }
}
