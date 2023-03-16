import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/routes.dart';
import 'package:app_cargo/widgets/app_save_button_second_ui.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class AppOmniRefinancingIntro extends StatefulWidget {
  @override
  _AppOmniRefinancingIntroState createState() =>
      _AppOmniRefinancingIntroState();
}

class _AppOmniRefinancingIntroState extends State<AppOmniRefinancingIntro> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
        backgroundColor: AppColors.gradient_green,
        widgetTitle: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.only(bottom: 30),
              height: 500,
              decoration: BoxDecoration(
                color: AppColors.omni_intro01_grey_color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    child: Text(
                        "Refinanciamento descomplicado para utilitários e veículos leves!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.light_blue,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600)),
                  ),
                  Image.asset("assets/images/omni_intro01.jpg",
                      fit: BoxFit.cover)
                ],
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                height: 500,
                margin: EdgeInsets.only(left: 50, right: 50, top: 20),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColors.yellow,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Avançar".toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.keyboard_arrow_right)
                    ],
                  ),
                ))
          ],
        ),
        directionColorBegin: Alignment.bottomCenter,
        directionColorEnd: Alignment.topCenter,
        onCenterItemPress: () {},
      ),
    );
    slides.add(
      new Slide(
        backgroundColor: AppColors.gradient_green,
        widgetTitle: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.only(bottom: 30),
              height: 500,
              decoration: BoxDecoration(
                color: AppColors.omni_intro02_grey_color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    child: Text(
                        "Melhores taxas e condições com parcelas que cabem no seu bolso!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.light_blue,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600)),
                  ),
                  Image.asset("assets/images/omni_intro02.png",
                      fit: BoxFit.cover)
                ],
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                height: 500,
                margin: EdgeInsets.only(left: 50, right: 50, top: 20),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColors.yellow,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Avançar".toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.keyboard_arrow_right)
                    ],
                  ),
                ))
          ],
        ),
        directionColorBegin: Alignment.topRight,
        directionColorEnd: Alignment.bottomLeft,
      ),
    );
    slides.add(
      new Slide(
        backgroundColor: AppColors.gradient_green,
        widgetTitle: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.only(bottom: 30),
              height: 500,
              decoration: BoxDecoration(
                color: AppColors.omni_intro03_grey_color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/images/omni_intro03.jpg",
                      fit: BoxFit.cover)
                ],
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                height: 500,
                margin: EdgeInsets.only(left: 50, right: 50, top: 20),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColors.yellow,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Concluído".toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.check)
                    ],
                  ),
                ))
          ],
        ),
        directionColorBegin: Alignment.topCenter,
        directionColorEnd: Alignment.bottomCenter,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IntroSlider(
          slides: this.slides,
          backgroundColorAllSlides: AppColors.gradient_green,
          colorDot: AppColors.grey,
          colorActiveDot: AppColors.yellow,
          sizeDot: 8,
          renderSkipBtn: AppText(
            "Pular",
            textColor: AppColors.white,
          ),
          renderNextBtn: Icon(
            Icons.navigate_next,
            color: AppColors.white,
            size: 35.0,
          ),
          renderDoneBtn: Icon(
            Icons.done,
            color: AppColors.white,
          ),
          onDonePress: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, Routes.omniMenuOptions);
          },
        ),
        Positioned(
          child: Container(
            height: 150,
            padding: EdgeInsets.only(
              right: 200,
            ),
            // color: AppColors.yellow,
            child: new Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 10),
              height: 200,
              decoration: new BoxDecoration(
                  color: AppColors.white,
                  // shape: BoxShape.values[
                  //
                  // ],
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: FittedBox(
                // alignment: Alignment.topLeft,
                fit: BoxFit.cover,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 1, minHeight: 1),
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 70,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
