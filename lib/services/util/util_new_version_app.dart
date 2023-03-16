import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';

///
/// Este Singleton realiza a verificação de atualização do App.
/// Se houver alguma atualização disponível na loja uma caixa de alerta
/// informa o usuário assim que ele abrir a aplicação.
///
/// A chamada deste singleton está acontecendo em "lib/screens/menu.dart" ao final do método init.State(){}.
///

class NewVersionApp {
  static NewVersionApp versionApp;
  BuildContext context;

  factory NewVersionApp({@required BuildContext context}) {
    return versionApp = NewVersionApp._checkNewVersion(context);
  }

  NewVersionApp._checkNewVersion(this.context) {
    getStatusApp(context: context);
  }

  Future<void> getStatusApp({BuildContext context}) async {
    final status = await NewVersion(context: context).getVersionStatus();
    if (status != null) {
      print(
        '* Versão local do app: ${status.localVersion}\n* Versão disponível na loja: ${status.storeVersion}\n* Requer atualização: ${status.canUpdate == true ? 'Sim -> Link: ${status.appStoreLink}' : 'Não'}',
      );
      if (status.canUpdate) {
        NewVersion(
          context: context,
          androidId: 'br.com.appcargo', //'com.snapchat.android',
          dialogTitle: 'Atualizar o AppCargo?',
          dialogText:
              'Recomendação: atualize este aplicativo para versão mais recente.',
          updateText: 'Atualizar',
          dismissText: 'Talvez mais tarde',
          dismissAction: () {
            Navigator.pop(context);
          },
        ).showAlertIfNecessary();
      }
    } else {
      print('status: $status');
    }
  }
}
