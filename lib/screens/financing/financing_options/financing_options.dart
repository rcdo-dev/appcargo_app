import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/omni/financing_options/omni_financing_options.dart';
import 'package:app_cargo/http/transformers.dart';
import 'package:app_cargo/routes.dart';
import 'package:app_cargo/services/omni/omni_service.dart';
import 'package:app_cargo/widgets/app_loading_text.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FinancingOptions extends StatefulWidget {
  const FinancingOptions({Key key}) : super(key: key);

  @override
  _FinancingOptionsState createState() => _FinancingOptionsState();
}

class _FinancingOptionsState extends State<FinancingOptions> {
  OmniService omniService = DIContainer().get<OmniService>();

  String simulationFriendlyHash;
  Future _loaded;
  bool firstLoaded = false;

  List<OmniFinancingOptions> _financingOptionsList =
      List<OmniFinancingOptions>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    if (args != null && args.isNotEmpty) {
      simulationFriendlyHash = args["proposal_friendly_hash"] as String;
    }

    if (!firstLoaded) {
      firstLoaded = true;

      _loaded = omniService
          .getFinancingOptions(simulationFriendlyHash)
          .then((financingOptions) {
        setState(() {
          _financingOptionsList.addAll(financingOptions);
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
                  "ESCOLHA UMA DA OPÇÕES ABAIXO:",
                  fontSize: 18,
                  weight: FontWeight.bold,
                  textColor: AppColors.black,
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Container(
                child: FutureBuilder(
                  future: _loaded,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        return _financingOptionsList.isEmpty
                            ? Container(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                        "Houve um erro ao recuperar as informações de financiamento"),
                                  ],
                                ),
                              )
                            : GridView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: _financingOptionsList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                    children: <Widget>[
                                      Container(
                                        height: 140,
                                        width: 180,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "OPÇÃO ${index + 1}",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color:
                                                        AppColors.light_green),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                "Prazo em ${_financingOptionsList[index].installments}x",
                                                style: TextStyle(fontSize: 11),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                child: Text(
                                                  "Valor do veículo: ${formatCurrencyValue(_financingOptionsList[index].totalPrice)}",
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ),
                                              Text(
                                                "Valor financiado: ${_financingOptionsList[index].financedAmount == null ? 0 : formatCurrencyValue(_financingOptionsList[index].financedAmount)}",
                                                style: TextStyle(fontSize: 11),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                child: Text(
                                                  "Taxa: ${_financingOptionsList[index].rate}%",
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        child: RaisedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                Routes.financingOptionDetails,
                                                arguments: {
                                                  "financing_option":
                                                      _financingOptionsList[
                                                          index],
                                                  "number_option": (index + 1),
                                                  "proposal_friendly_hash":
                                                      simulationFriendlyHash
                                                });
                                          },
                                          color: AppColors.light_green,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: AppText(
                                            "VER MAIS",
                                            textColor: AppColors.white,
                                            fontSize: 11,
                                            weight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      )
                                    ],
                                  );
                                });

                        break;

                      default:
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AppLoadingWidget(),
                          ],
                        );
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
