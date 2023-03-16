import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/domain/omni/financing_options/omni_financing_options.dart';
import 'package:app_cargo/http/transformers.dart';
import 'package:app_cargo/routes.dart';
import 'package:flutter/material.dart';

class FinancingOptionsDetails extends StatefulWidget {
  const FinancingOptionsDetails({Key key}) : super(key: key);

  @override
  _FinancingOptionsDetailsState createState() =>
      _FinancingOptionsDetailsState();
}

class _FinancingOptionsDetailsState extends State<FinancingOptionsDetails> {
  OmniFinancingOptions _omniFinancingOption;
  int numberOption;
  String proposalFriendlyHash;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    if (args != null && args.isNotEmpty) {
      numberOption = args["number_option"] as int;
      _omniFinancingOption = args["financing_option"] as OmniFinancingOptions;
      proposalFriendlyHash = args["proposal_friendly_hash"] as String;
    }

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Stack(
            children: <Widget>[
              Container(
                height: 600,
                decoration: BoxDecoration(color: Colors.grey[350]),
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("OPÇÃO ${numberOption}"),
                      Divider(thickness: 1, color: AppColors.white),
                      SizedBox(height: 15),
                      Text(
                        "Prazo em ${_omniFinancingOption.installments}x",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Valor total: ${formatCurrencyValue(_omniFinancingOption.totalPrice)}",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10),

                      Text(
                        "Valor financiado: ${formatCurrencyValue(_omniFinancingOption.financedAmount)}",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Valor da parcela: ${formatCurrencyValue(_omniFinancingOption.installmentValue)}",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Taxa: ${_omniFinancingOption.rate}%",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10),

                      // SizedBox(height: 10),
                      //
                      // SizedBox(height: 10),
                      // Text(
                      //   "Valor líquido: ${formatCurrencyValue(_omniFinancingOption.netValue)}",
                      //   style: TextStyle(fontSize: 14),
                      // ),
                      // SizedBox(height: 10),
                      // Text(
                      //   "Valor SIRCOF: ${formatCurrencyValue(_omniFinancingOption.sircofValue)}",
                      //   style: TextStyle(fontSize: 14),
                      // ),
                      // SizedBox(height: 10),
                      // Text(
                      //   "Valor TC: ${formatCurrencyValue(_omniFinancingOption.tcValue)}",
                      //   style: TextStyle(fontSize: 14),
                      // ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 575),
                child: ButtonTheme(
                  minWidth: 200,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.optionSelectedForm,
                          arguments: {
                            "proposal_friendly_hash": proposalFriendlyHash,
                            "refinancing_option_friendly_hash":
                                _omniFinancingOption.friendlyHash,
                            "refinancing_option_number": numberOption
                          });
                    },
                    textColor: AppColors.white,
                    color: AppColors.yellow,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 5,
                    child: Text(
                      "ENVIAR",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
