import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/freight_company_detail/freight_company_detail.dart';
import 'package:app_cargo/domain/freight_company_feedback/freight_company_feedback.dart';
import 'package:app_cargo/services/freight_company/freight_company_mock_service.dart';
import 'package:app_cargo/services/freight_company/freight_company_service.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class AppEvaluateCompany extends StatefulWidget {
  final FreightCompanyDetail _freightCompanyDetail;

  const AppEvaluateCompany(this._freightCompanyDetail, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _AppEvaluateCompanyState(_freightCompanyDetail);
}

class _AppEvaluateCompanyState extends State<AppEvaluateCompany> {
  final FreightCompanyDetail _freightCompanyDetail;
  final FreightCompanyService _freightCompanyService =
      DIContainer().get<FreightCompanyService>();
  int stars;
  TextEditingController description;

  void initState() {
    stars = 1;
    description = new TextEditingController();
    super.initState();
  }

  _AppEvaluateCompanyState(this._freightCompanyDetail);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
            alignment: Alignment.center,
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: AppColors.blue),
              borderRadius: BorderRadius.all(
                  Radius.circular(5.0) //         <--- border radius here
                  ),
            ),
            child: Image.network(
              _freightCompanyDetail.photo,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
            child: SkyText(
              _freightCompanyDetail.name,
              textColor: AppColors.blue,
              fontSize: 20,
            ),
          ),
          Container(
            child: _buildStarsRating(),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
            child: AppTextField(
              label: "Opinião",
              labelColor: AppColors.blue,
              hint: "Diga algo sobre a companhia",
              textEditingController: description,
            ),
          ),
          AppSaveButton(
            "ENVIAR AVALIAÇÃO",
            onPressed: () {
              if(description.text.trim().length == 0){
                showMessageDialog(context, message: "Escreva um breve resumo sobre sua experiência com a transportadora", type: DialogType.WARNING);
                return;
              }
              showLoadingThenOkDialog(
                context,
                _freightCompanyService.postCompanyFeedbackPaged(
                    new FreightCompanyFeedback(
                        rating: stars, description: description.text),
                    _freightCompanyDetail.hash),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStarsRating() {
    List<Widget> widgets = new List<Widget>(5);
    List<bool> rating = new List<bool>(5);

    for (int i = 0; i < stars; i++) {
      rating[i] = true;
    }

    for (int i = stars; i < 5; i++) {
      rating[i] = false;
    }

    for (int i = 0; i < 5; i++) {
      widgets[i] = new Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimen.vertical_padding,
            vertical: Dimen.horizontal_padding),
        child: GestureDetector(
          child: Icon(
            rating[i] ? Icons.star : Icons.star_border,
            color: AppColors.green,
            size: 35,
          ),
          onTap: () {
            setState(() {
              stars = i + 1;
              print(stars.toString());
            });
          },
        ),
      );
    }

    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }
}
