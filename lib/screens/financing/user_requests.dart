import 'package:app_cargo/app.dart';
import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/constants/omni_environments.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/omni/users_proposals/simulation_data.dart';
import 'package:app_cargo/http/transformers.dart';
import 'package:app_cargo/routes.dart';
import 'package:app_cargo/screens/financing/widgets/app_circle_status.dart';
import 'package:app_cargo/screens/financing/widgets/app_proposals_show_more_button.dart';
import 'package:app_cargo/screens/financing/widgets/app_show_request_details.dart';
import 'package:app_cargo/services/omni/omni_service.dart';
import 'package:app_cargo/widgets/app_confirm_popup.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class UserRequests extends StatefulWidget {
  @override
  _UserRequestsState createState() => _UserRequestsState();
}

class _UserRequestsState extends State<UserRequests> {
  OmniService omniService = DIContainer().get<OmniService>();

  Future _loaded;

  List<SimulationData> _simulationList = new List<SimulationData>();

  @override
  void initState() {
    super.initState();

    _loaded = omniService.mySimulations().then((simulationList) {
      if (simulationList == null) {
        return;
      } else {
        return _simulationList.addAll(simulationList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 210,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 8,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.only(bottom: 20),
                          child: AppText(
                            "STATUS DA SUA SOLICITAÇÃO",
                            weight: FontWeight.bold,
                            textColor: AppColors.light_green,
                            textAlign: TextAlign.center,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      child: Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    child: Image(
                      image: AssetImage('assets/images/ic_header.png'),
                      fit: BoxFit.cover,
                    ),
                  )),
                  FractionalTranslation(
                    translation: Offset(0.0, 0.5),
                    child: new Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 5),
                      height: 100,
                      decoration: new BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: FittedBox(
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minWidth: 1, minHeight: 1),
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AppText(
                      "MINHAS SIMULAÇÕES",
                      fontSize: 12,
                      weight: FontWeight.bold,
                      textColor: Colors.grey[600],
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      color: AppColors.light_green,
                      textColor: AppColors.white,
                      child: Text("Nova simulação"),
                    )
                  ],
                ),
              ),
              Container(
                height: 450,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: FutureBuilder<Object>(
                    future: _loaded,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          return _simulationList.isEmpty
                              ? Container(
                                  padding: EdgeInsets.only(bottom: 50),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: 80,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/ic_truck.png"))),
                                      ),
                                      AppText(
                                        "Você ainda não realizou nenhuma simulação.",
                                        fontSize: 20,
                                        textColor: AppColors.green,
                                        weight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                )
                              : GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: false,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: _simulationList.length,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: 4,
                                    mainAxisSpacing: 1,
                                    crossAxisSpacing: 1,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      // decoration:
                                      //     BoxDecoration(color: Colors.teal.withOpacity(0.5)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              AppCircleStatus(
                                                status: _simulationList[index]
                                                    .status,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                        "Placa: ${_simulationList[index].licensePlate}"),
                                                  ),
                                                  Container(
                                                    width: 150,
                                                    child: Text(
                                                        "${_simulationList[index].statusText}",
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: AppColors
                                                                .grey)),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  AppText(
                                                    "Data da solicitação",
                                                    textColor: Colors.grey[800],
                                                    fontSize: 9,
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  AppText(
                                                    "${dateToJson(DateTime.parse(_simulationList[index].requestDate))}",
                                                    textColor: Colors.grey[800],
                                                    fontSize: 14,
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  AppProposalsShowMoreButton(
                                                    status:
                                                        _simulationList[index]
                                                            .status,
                                                    friendlyHash:
                                                        _simulationList[index]
                                                            .friendlyHash,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          Container(
                                            child: Divider(
                                              color: AppColors.light_green,
                                              height: 1,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                        default:
                          return AppLoadingWidget();
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
