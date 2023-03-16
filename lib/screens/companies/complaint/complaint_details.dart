import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/complaint_details/complaint_details.dart';
import 'package:app_cargo/domain/complaint_reply/complaint_reply.dart';
import 'package:app_cargo/screens/companies/complaint/widget/app_complaint_messages.dart';
import 'package:app_cargo/services/complaint/complaint_mock_service.dart';
import 'package:app_cargo/widgets/app_action_button.dart';
import 'package:app_cargo/widgets/app_confirm_popup.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../../routes.dart';

class ComplaintDetailsScreen extends StatelessWidget {
  final ComplaintMockService _complaintService =
      DIContainer().get<ComplaintMockService>();

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
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                      top: Dimen.vertical_padding + 10,
                      bottom: Dimen.vertical_padding),
                  child: SkyText(
                    "Assunto",
                    fontSize: 20,
                    textColor: AppColors.blue,
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                            top: Dimen.vertical_padding,
                            bottom: Dimen.vertical_padding + 10),
                        child: SkyText(
                          _complaintDetails.code,
                          fontSize: 18,
                          textColor: AppColors.green,
                        ),
                      ),
                      AppComplaintMessages(
                        answer: false,
                        message: _complaintDetails.message,
                      ),
                      _buildReplies(_complaintDetails.replies),
                    ],
                  ),
                ),
                AppSaveButton(
                  "SOLUCIONADO",
                  onPressed: () {
                    showAppConfirmPopup(
                      context,
                      "Deseja realmente fechar está reclamação ?",
                      "Após fechada ela não poderá ser reaberta.",
                      "SIM",
                      () {
                        Navigator.pop(context);
                        showLoadingThenOkDialog(
                          context,
                          _complaintService
                              .closeComplaint(_complaintDetails)
                              .then(
                            (value) {
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                      cancelOptionTitle: "NÃO",
                      onCancel: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                AppActionButton(
                  "RESPONDER",
                  fontSize: 17,
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.complaintAnswer,
                        arguments: {"complaintDetails": _complaintDetails});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReplies(List<ComplaintReply> replies) {
    List<Widget> _replies = new List<Widget>();
    if (replies.length <= 0) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: Dimen.horizontal_padding),
        child: SkyText(
          "Sem respostas ate o momento.",
          fontSize: 20,
          textColor: AppColors.blue,
          textAlign: TextAlign.center,
        ),
      );
    }
    for (ComplaintReply _reply in replies) {
      _replies.add(
        AppComplaintMessages(
          answer: _reply.isFreightCo,
          message: _reply.message,
        ),
      );
    }
    return Column(
      children: _replies,
    );
  }
}
