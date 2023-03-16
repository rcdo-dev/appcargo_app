import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/freight_summary/freight_summary.dart';
import 'package:app_cargo/screens/freight/widget/AppFreightItem.dart';
import 'package:app_cargo/services/me/me_service.dart';
import 'package:app_cargo/widgets/app_horizontal_divider.dart';
import 'package:app_cargo/widgets/app_loading_widget.dart';
import 'package:app_cargo/widgets/app_refresh_indicator.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/constants/app_colors.dart';
import 'package:flutter_skywalker_core/flutter_skywalker_core.dart';

class FreightHistory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FreightHistoryState();
}

class _FreightHistoryState extends State<FreightHistory> {
  final MeService meService = DIContainer().get<MeService>();
  int page = 0;
  int pageSize = 10;
  bool canLoadMore = true;
  ScrollController _scrollController;
  List<Widget> _freightList;

  void initState() {
    _freightList = new List();
    _scrollController = new ScrollController();
    _scrollController.addListener(_scrollListener);
    _updateHistoryListView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "FRETES",
      body: Column(
        children: <Widget>[
          Container(
            child: Container(
              decoration: new BoxDecoration(
                color: AppColors.white,
                borderRadius: new BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: Dimen.horizontal_padding,
                  vertical: Dimen.vertical_padding),
              child: Column(
                children: <Widget>[
                  Container(
                    child: SkyText(
                      "MEUS FRETES",
                      textColor: AppColors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: AppRefreshIndicator(
                      content: ListView.builder(
                        itemCount: _freightList.length,
                        itemBuilder: (context, index) {
                          return _itemListViewBuilder(index);
                        },
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                      ),
                      onRefresh: () => Future.delayed(
                        Duration(seconds: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _scrollListener() {
    // If is at the bottom, load more freights
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      page += 1;
      _updateHistoryListView();
    }
  }

  void _updateHistoryListView() async {
    // Verification to avoid multiple requests to the server
    if (canLoadMore) {
      // Block for new requests
      canLoadMore = false;

      // Add a Loading Widget at the button to show that we are loading more freights
      setState(() {
        _freightList.add(AppLoadingWidget());
      });

      // Get new freights
      List<FreightSummary> _listFreightSummary =
          await meService.getFreightHistory(page, pageSize);

      // Remove the Loading Widget because we've already get the new freights
      _freightList.removeLast();

      // Verify if the driver's don't have more freights to load
      if (_listFreightSummary.length <= 0) {
        setState(() {
          _freightList = [
            new Container(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: SkyText(
                "Você ainda não realizou nenhum frete",
                textColor: AppColors.green,
                fontSize: 20,
              ),
            )
          ];
        });
      }

      // Pass throw each FreightSummary, build their widget and update the screen
      for (FreightSummary _freightSummary in _listFreightSummary) {
        setState(() {
          // Freight widget
          _freightList.add(new Container(
            padding:
                EdgeInsets.symmetric(vertical: Dimen.vertical_padding + 10),
            child: AppFreightItem(
              null,
              freightSummary: _freightSummary,
            ),
          ));
        });

        // Horizontal divider
        setState(() {
          _freightList.add(AppHorizontalDivider());
        });
      }

      // Free to make new requests
      canLoadMore = true;
    }
  }

  Widget _itemListViewBuilder(int index) {
    return _freightList[index];
  }
}
