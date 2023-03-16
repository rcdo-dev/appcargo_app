import 'package:app_cargo/domain/freight_details/freight_details.dart';
import 'package:app_cargo/screens/freight/widget/AppFreightInfo.dart';
import 'package:flutter/material.dart';

class FreightInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FreightInfoState();
}

class _FreightInfoState extends State<FreightInfo> {
  Map<String, dynamic> args;
  FreightDetails freightDetails;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    if (null != args && args.isNotEmpty) {
      freightDetails = args["freightDetails"] as FreightDetails;
    }
    return AppFreightInfo(freightDetails, proposal: false,);
  }
}
