import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/omni_environments.dart';
import 'package:app_cargo/routes.dart';
import 'package:app_cargo/screens/financing/widgets/app_show_request_details.dart';
import 'package:app_cargo/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppProposalsShowMoreButton extends StatelessWidget {
  String status;
  String friendlyHash;

  AppProposalsShowMoreButton(
      {@required this.status, @required this.friendlyHash});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: RaisedButton(
        onPressed: () {
          if (status == OmniEnvironments.refused)
            buildDialog(
                context,
                "Infelizmente não foi dessa vez...",
                "Sua solicitação foi reprovada pelo banco. Tente novamente em XX meses.",
                status,
                friendlyHash);

          if (status == OmniEnvironments.approved)
            buildDialog(
                context,
                "Parabéns!".toUpperCase(),
                "Seu financiamento foi aprovado com sucesso.\n\nEm até XX dias um "
                "representante do banco OMNI entrará em contato com você.",
                status,
                friendlyHash);

          if (status == OmniEnvironments.preApproved)
            buildDialog(
                context,
                "Solicitação Pré-Aprovada",
                "Selecione uma opção de refinanciamento para prosseguir.",
                status,
                friendlyHash);

          if (status == OmniEnvironments.finishedSimulation)
            buildDialog(
                context,
                "A opção selecionada está sendo analisada pelo banco",
                "Em até XX dias você receberá uma notificação com status da sua solicitação.",
                status,
                friendlyHash);

          if (status == OmniEnvironments.submittedToPreApproval)
            buildDialog(
                context,
                "Seus dados já foram enviados!",
                "Em até 02 dias você receberá uma notificação com status da sua solicitação.",
                status,
                friendlyHash);
        },
        color: AppColors.light_green,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: AppText(
          "Ver mais",
          textColor: AppColors.white,
          fontSize: 9,
        ),
      ),
    );
  }

  void buildDialog(BuildContext context, String title, String content,
      String status, String friendlyHash) {
    showAppRequestDetails(
      context,
      title,
      content,
      "OK",
      () {
        if (status == OmniEnvironments.preApproved) {
          Navigator.pushNamed(context, Routes.financingOption,
              arguments: {"proposal_friendly_hash": friendlyHash});
        } else {
          Navigator.pop(context);
        }
      },
      cancelOptionTitle: "Histórico",
      onCancel: () {
        Navigator.pushNamed(context, Routes.requestsHistory,
            arguments: {"proposal_friendly_hash": friendlyHash});
      },
      titleColor: AppColors.black,
      contentColor: Colors.grey[700],
    );
  }
}
