import 'package:app_cargo/app.dart';
import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/omni/proposals_history/history_users_proposals.dart';
import 'package:app_cargo/http/transformers.dart';
import 'package:app_cargo/screens/financing/widgets/app_circle_status.dart';
import 'package:app_cargo/services/omni/omni_service.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:flutter/material.dart';

class PlateRequestHistory extends StatefulWidget {
  @override
  _PlateRequestHistoryState createState() => _PlateRequestHistoryState();
}

class _PlateRequestHistoryState extends State<PlateRequestHistory> {
  OmniService omniService = DIContainer().get<OmniService>();

  String simulationFriendlyHash;
  Future _loaded;
  bool firstLoaded = false;

  HistoryUsersProposals _historyUsersProposals;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    if (args != null && args.isNotEmpty) {
      simulationFriendlyHash = args["proposal_friendly_hash"] as String;
    }

    if (!firstLoaded) {
      firstLoaded = true;
      _loaded = omniService
          .proposalsHistoryRequest(simulationFriendlyHash)
          .then((history) {
        setState(() {
          _historyUsersProposals = history;
        });
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 80),
                alignment: Alignment.topLeft,
                child: AppText(
                  "HISTÓRICO",
                  fontSize: 18,
                  weight: FontWeight.bold,
                  textColor: AppColors.black,
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Container(
                // height: 500,

                child: FutureBuilder(
                  future: _loaded,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        return _historyUsersProposals == null
                            ? Container(
                                child: Text(
                                    "Houve um erro ao recuperar o histórico"),
                              )
                            : Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    alignment: Alignment.topLeft,
                                    child: AppText(
                                      "PLACA - ${_historyUsersProposals.licensePlate}",
                                      fontSize: 14,
                                      weight: FontWeight.bold,
                                      textColor: Colors.grey[600],
                                    ),
                                  ),

                                  GridView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: _historyUsersProposals
                                          .financingHistoryEntry.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        childAspectRatio: 5,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 1,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  AppCircleStatus(
                                                    status: _historyUsersProposals
                                                        .financingHistoryEntry[
                                                            index]
                                                        .status,
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        AppText(
                                                          "${_historyUsersProposals.financingHistoryEntry[index].statusText}",
                                                          textColor:
                                                              AppColors.grey,
                                                          fontSize: 14,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Container(
                                                                child: AppText(
                                                                    "Data da notificação: ",
                                                                    fontSize:
                                                                        12,
                                                                    textColor:
                                                                        AppColors
                                                                            .grey)),
                                                            Container(
                                                                child: AppText(
                                                                    "${dateToJson(DateTime.parse(_historyUsersProposals.financingHistoryEntry[index].date))}",
                                                                    fontSize:
                                                                        12,
                                                                    textColor:
                                                                        AppColors
                                                                            .grey)),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                child: Divider(
                                                  color: AppColors.grey,
                                                  height: 1,
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                ],
                              );

                        break;

                      default:
                        return AppLoadingWidget();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
