import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/freight_company_detail/freight_company_detail.dart';
import 'package:app_cargo/screens/freight/widget/AppCarrierInfo.dart';
import 'package:app_cargo/services/freight_company/freight_company_service.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:app_cargo/widgets/app_screen_message.dart';
import 'package:app_cargo/widgets/show_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class CarrierInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CarrierInfoState();
}

class _CarrierInfoState extends State<CarrierInfo> {
  FreightCompanyService _freightCompanyService =
      DIContainer().get<FreightCompanyService>();
  FreightCompanyDetail _freightCompanyDetail;
  String freightCompanyHash;
  bool _hasLoaded;
  Future _loaded;

  @override
  void initState() {
    super.initState();
    _hasLoaded = false;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    if (null != args && args.isNotEmpty) {
      freightCompanyHash = args["freightCompanyHash"] as String;
    }

    if (!_hasLoaded) {
      _loaded = _freightCompanyService
          .getCompanyDetails(freightCompanyHash)
          .then((freightCompanyDetails) {
        print(FreightCompanyDetail.toJson(freightCompanyDetails));
        _freightCompanyDetail = freightCompanyDetails;
        _hasLoaded = true;
      });
    }

    return AppScaffold(
      title: "EMPRESAS",
      body: Column(
        children: <Widget>[
          Container(
            child: Container(
              decoration: new BoxDecoration(
                  color: AppColors.white,
                  borderRadius: new BorderRadius.all(Radius.circular(10))),
              padding: EdgeInsets.symmetric(
                  horizontal: Dimen.horizontal_padding,
                  vertical: Dimen.horizontal_padding),
              child: FutureBuilder(
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      return _buildFreightCompanyInfoWidget(
                          _freightCompanyDetail);
                      break;
                    default:
                      return AppLoadingWidget();
                  }
                },
                future: _loaded,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFreightCompanyInfoWidget(
      FreightCompanyDetail freightCompanyDetail) {
    if (freightCompanyDetail != null) {
      return Column(
        children: <Widget>[
          AppCarrierInfo(freightCompanyDetail),
//          Container(
//            child: SkyFlatButton(
//              textColor: AppColors.blue,
//              text: "Ver mais avaliaçoes",
//              fontSize: 20,
//            ),
//          ),
        ],
      );
    } else {
      return AppScreenError(
        dialogType: DialogType.ERROR,
        message: "A transportadora pela qual está procurando não existe",
      );
    }
  }
}
