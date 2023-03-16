import 'dart:collection';

import 'package:app_cargo/domain/freight_details/freight_details.dart';
import 'package:app_cargo/screens/freight/widget/AppFreightInfo.dart';
import 'package:flutter/material.dart';

class FreightProposal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FreightProposalState();
}

class _FreightProposalState extends State<FreightProposal> {
  Map<String, dynamic> args;
  FreightDetails freightDetails;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    if (null != args && args.isNotEmpty) {
      freightDetails = args["freightDetails"] as FreightDetails;
    }
    return AppFreightInfo(
      freightDetails,
      proposal: true,
    );
  }
}
