import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/bank/bank.dart';
import 'package:app_cargo/domain/bank/banks.dart';
import 'package:app_cargo/services/util/util_service.dart';
import 'package:app_cargo/widgets/app_dropdown_button.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class AppBanksDropDown extends StatefulWidget {
  final Bank selectedBank;
  final Function onChange;

  const AppBanksDropDown({Key key, this.selectedBank, this.onChange})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _AppBanksDropDownState(selectedBank, onChange);
}

class _AppBanksDropDownState extends State<AppBanksDropDown> {
  final UtilService _utilService = DIContainer().get<UtilService>();
  final Bank selectedBank;
  final Function onChange;
  Future<Banks> _loaded;

  _AppBanksDropDownState(this.selectedBank, this.onChange);

  @override
  void initState() {
    super.initState();
    _loaded = _utilService.getBanks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData) {
              return _buildBanksWidget(snapshot.data);
            } else {
              return Container(
                child: SkyText("Erro"),
              );
            }
            break;
          default:
            return AppLoadingWidget();
        }
      },
      future: _loaded,
    );
  }

  Widget _buildBanksWidget(Banks banks) {
    return AppDropdownButton<Bank>(
      resolver: (bank) => bank.name,
      currentItem: selectedBank,
      createFriendlyFirstItem: true,
      items: banks.banks,
      onChanged: (Bank bank) {
        onChange(bank);
      },
    );
  }
}
