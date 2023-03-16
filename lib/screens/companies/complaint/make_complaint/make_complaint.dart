import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/complaint_details/complaint_details.dart';
import 'package:app_cargo/services/complaint/complaint_mock_service.dart';
import 'package:app_cargo/services/complaint/complaint_service.dart';
import 'package:app_cargo/widgets/app_dropdown_button.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/app_selectable_image.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

part 'make_complaint_controller.dart';

class MakeComplaint extends StatelessWidget {
  final MakeComplaintController _makeComplaintController =
      new MakeComplaintController();
  final ComplaintMockService _complaintService =
      DIContainer().get<ComplaintMockService>();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "CONFIGURAÇÕES",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: AppColors.white,
            ),
            padding: EdgeInsets.symmetric(
                vertical: Dimen.horizontal_padding,
                horizontal: Dimen.horizontal_padding),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimen.vertical_padding,
                            horizontal: Dimen.horizontal_padding - 5),
                        child: Icon(
                          Icons.warning,
                          size: 25,
                          color: AppColors.blue,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimen.vertical_padding,
                            horizontal: Dimen.horizontal_padding - 5),
                        child: SkyText(
                          "RECLAMAÇOES",
                          fontSize: 25,
                          textColor: AppColors.blue,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimen.vertical_padding + 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            vertical: Dimen.vertical_padding),
                        child: SkyText(
                          "Assunto",
                          fontSize: 19,
                          textColor: AppColors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: AppDropdownButton.options(
                            ["Aplicativo", "Pagamento"], onChanged: (value) {
                          _makeComplaintController.subject = value;
                        }),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
                  child: SkyText(
                    "Mensagem",
                    fontSize: 19,
                    textColor: AppColors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: Dimen.vertical_padding + 10),
                  child: AppTextField(
                    maxLines: 5,
                    verticalContentPadding: 5,
                    horizontalContentPadding: 5,
                    suffixIcon: Container(
                      padding: EdgeInsets.only(top: 70, left: 15),
                      child: Icon(
                        Icons.mic,
                        color: AppColors.blue,
                        size: 19,
                      ),
                    ),
                    textEditingController: _makeComplaintController.message,
                  ),
                ),
                Container(
                  child: AppSelectableImage.medium(),
                ),
                AppSaveButton(
                  "ENVIAR RECLAMAÇAO",
                  onPressed: () {
                    print(ComplaintDetails.toJson(_makeComplaintController.getComplaintDetails()).toString());
                    showLoadingThenOkDialog(
                      context,
                      _complaintService.createComplaint(
                        _makeComplaintController.getComplaintDetails(),
                      ),
                      popTwiceOnOk: true,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
