import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/complaint_details/complaint_details.dart';
import 'package:app_cargo/domain/complaint_reply/complaint_reply.dart';
import 'package:app_cargo/services/complaint/complaint_mock_service.dart';
import 'package:app_cargo/services/complaint/complaint_service.dart';
import 'package:app_cargo/widgets/app_action_button.dart';
import 'package:app_cargo/widgets/app_dropdown_button.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/app_selectable_image.dart';
import 'package:app_cargo/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'complaint_answer_controller.dart';

class ComplaintAnswer extends StatelessWidget {
  final ComplaintMockService _complaintService =
      DIContainer().get<ComplaintMockService>();
  final ComplaintAnswerController _answerController =
      new ComplaintAnswerController();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    ComplaintDetails _complaintDetails;
    if (null != args && args.isNotEmpty) {
      _complaintDetails = args["complaintDetails"] as ComplaintDetails;
    }
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
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
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                            bottom: Dimen.vertical_padding + 10),
                        child: SkyText(
                          _complaintDetails.code,
                          fontSize: 17,
                          textColor: AppColors.green,
                        ),
                      )
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
                    textEditingController: _answerController.message,
                  ),
                ),
                AppSelectableImage.medium(),
                AppSaveButton(
                  "RESPONDER",
                  onPressed: () {
                    showLoadingThenOkDialog(
                      context,
                      _complaintService.replyComplaint(
                        _answerController.getComplaintReply(),
                        _complaintDetails.hash,
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
