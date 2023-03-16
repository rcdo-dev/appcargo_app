import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/complaint_details/complaint_details.dart';
import 'package:app_cargo/domain/complaint_summary/complaint_summary.dart';
import 'package:app_cargo/domain/complaints/complaints.dart';
import 'package:app_cargo/services/complaint/complaint_mock_service.dart';
import 'package:app_cargo/services/complaint/complaint_service.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

import '../../../routes.dart';

class SettingsComplaint extends StatelessWidget {
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
                FutureBuilder(
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          return _buildComplaints(snapshot.data, context);
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 25),
                                child: SkyText(
                                  "Sem reclamações no momento.",
                                  textAlign: TextAlign.center,
                                  fontSize: 25,
                                  textColor: AppColors.green,
                                ),
                              ),
                            ],
                          );
                        }
                        break;
                      default:
                        return AppLoadingWidget();
                    }
                  },
                  future: _complaintService.getComplaints(),
                ),
                AppSaveButton(
                  "FAZER RECLAMAÇAO",
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.makeComplaint);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplaints(Complaints complaints, BuildContext context) {
    List<Widget> _widgets = new List<Widget>();
    _widgets.add(
      Container(
        child: SkyText(
          "Reclamações em aberto",
          textAlign: TextAlign.center,
          textColor: AppColors.green,
          fontSize: 17,
        ),
      ),
    );
    for (ComplaintDetails open in complaints.open) {
      _widgets.add(
        Container(
          padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
          alignment: Alignment.centerLeft,
          child: SkyFlatButton(
            text: open.code + " - " + open.subject,
            textColor: AppColors.blue,
            fontSize: 20,
            onPressed: () {
              Navigator.pushNamed(context, Routes.complaintDetails,
                  arguments: {"complaintDetails": open});
            },
          ),
        ),
      );
    }

    _widgets.add(
      Container(
        child: SkyText(
          "Reclamações em aberto",
          textAlign: TextAlign.center,
          textColor: AppColors.green,
          fontSize: 17,
        ),
      ),
    );
    for (ComplaintSummary closed in complaints.closed) {
      _widgets.add(
        Container(
          padding: EdgeInsets.symmetric(vertical: Dimen.vertical_padding),
          alignment: Alignment.centerLeft,
          child: SkyFlatButton(
            text: closed.code + " - " + closed.subject,
            textColor: AppColors.blue,
            fontSize: 20,
            onPressed: () {
              showLoadingThenOkDialog(
                      context, _complaintService.getComplaintDetails(closed))
                  .then((value) {
                if (value != null) {
                  Navigator.pushNamed(context, Routes.complaintDetails,
                      arguments: {"complaintDetails": value});
                }
              });
            },
            // TODO: Here we need to open the complaint details, but we don't have a endpoint to get the details from ComplaintSummary        ),
          ),
        ),
      );
    }
    return Column(
      children: _widgets,
    );
  }
}
