import 'package:app_cargo/db/decline_reasons_dao.dart';
import 'package:app_cargo/db/freight_proposals_dao.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/feight_proposal_decline_reasons/freight_proposal_decline_reasons.dart';
import 'package:app_cargo/domain/freight_details/freight_details.dart';
import 'package:app_cargo/services/freight/freight_mock_service.dart';
import 'package:app_cargo/services/freight/freight_service.dart';
import 'package:app_cargo/widgets/app_dropdown_button.dart';
import 'package:app_cargo/widgets/app_loading_dialog.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_save_button.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class FreightRefused extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FreightRefusedState();
}

class _FreightRefusedState extends State<FreightRefused> {
  final FreightService _freightService = DIContainer().get<FreightService>();
  List<FreightProposalDeclineReason> _listFreightProposalDeclineReason;
  FreightProposalDeclineReason declineReason;
  FreightDetails freightDetails;
  Map<String, dynamic> args;
  Future _loaded;

  @override
  void initState() {
    super.initState();
    _loaded = _freightService.getAllDeclineReasons().then((value) {
      _listFreightProposalDeclineReason = value;
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    if (null != args && args.isNotEmpty) {
      freightDetails = args["freightDetails"] as FreightDetails;
    }
    return AppScaffold(
      title: "FRETES",
      body: FutureBuilder(
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasError) {
                print(snapshot.error);
                return Container(
                  child: SkyText(
                    "Erro ao recuperar as rasoes para recusa de proposta!",
                    fontSize: 25,
                    textColor: AppColors.green,
                  ),
                );
              }
              return Column(
                children: <Widget>[
                  Container(
                    child: Container(
                      decoration: new BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              new BorderRadius.all(Radius.circular(10))),
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimen.horizontal_padding,
                          vertical: Dimen.vertical_padding),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: Dimen.vertical_padding + 10,
                            ),
                            child: SkyText(
                              "DESEJA REALMENTE RECUSAR ESSA PROPOSTA",
                              textColor: AppColors.green,
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.center,
                              fontSize: 30,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimen.vertical_padding + 10),
                            height: 150,
                            width: 666,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: AppDropdownButton<
                                  FreightProposalDeclineReason>(
                                items: _listFreightProposalDeclineReason,
                                onChanged:
                                    (FreightProposalDeclineReason selected) {
                                  this.declineReason = selected;
                                },
                                createFriendlyFirstItem: true,
                                resolver:
                                    (FreightProposalDeclineReason option) =>
                                        option.description,
                              ),
                            ),
                          ),
                          AppSaveButton(
                            "RECUSAR",
                            onPressed: () {
                              showLoadingThenOkDialog(
                                context,
                                _freightService.refuseFreightProposal(
                                    freightDetails, declineReason),
                                popTwiceOnOk: true,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
              break;
            default:
              return AppLoadingWidget();
          }
        },
        future: _loaded,
      ),
    );
  }
}
