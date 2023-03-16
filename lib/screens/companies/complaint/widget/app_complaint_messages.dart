import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/widgets/app_horizontal_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class AppComplaintMessages extends StatelessWidget {
  final bool answer;
  final String message;

  const AppComplaintMessages({Key key, this.answer, this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding + 10),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                child: SkyText(
                  answer ? "Resposta" : "Mensagem",
                  textAlign: TextAlign.start,
                  fontSize: 19,
                  textColor: AppColors.blue,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                child: SkyText(
                  message,
                  textAlign: TextAlign.justify,
                  fontSize: 17,
                  textColor: AppColors.green,
                ),
              ),
            ],
          ),
        ),
        AppHorizontalDivider(),
      ],
    );
  }
}
