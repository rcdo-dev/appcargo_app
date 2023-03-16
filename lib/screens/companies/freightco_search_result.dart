import 'package:app_cargo/constants/app_colors.dart';
import 'package:app_cargo/constants/dimen.dart';
import 'package:app_cargo/di/container.dart';
import 'package:app_cargo/domain/freight_company_summary/freight_company_summary.dart';
import 'package:app_cargo/domain/freight_summary/paged_freightco_summary.dart';
import 'package:app_cargo/services/freight_company/freight_company_service.dart';
import 'package:app_cargo/widgets/app_freightco_item.dart';
import 'package:app_cargo/widgets/app_horizontal_divider.dart';
import 'package:app_cargo/widgets/app_refresh_indicator.dart';
import 'package:app_cargo/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class FreightCoSearchArguments {
  String query;

  FreightCoSearchArguments(this.query);
}

class FreightCoSearchResultScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FreightCoSearchState();
}

class _FreightCoSearchState extends State<FreightCoSearchResultScreen> {
  FreightCompanyService _freightCoService;

  ScrollController _scrollController;

  List<FreightCompanySummary> _searchResults = [];

  bool _isLoading = false;
  bool _hasMoreResults = true;

  int _currentPage;
  int _pageSize;

  String _currentQuery = "";

  _FreightCoSearchState({
    int initialPage = 0,
    int pageSize = 5,
  }) {
    this._currentPage = initialPage;
    this._pageSize = pageSize;
    this._freightCoService = DIContainer().get<FreightCompanyService>();

    this._scrollController = new ScrollController();
    this._scrollController.addListener(_scrollHandler);
  }
  
  @override
  void initState() {
    super.initState();
    _fetchFreightCompanies();
  }

  @override
  Widget build(BuildContext context) {
    FreightCoSearchArguments args = ModalRoute.of(context).settings.arguments;
    this._currentQuery = args.query;

    return AppScaffold(
      title: "Resultados da Busca",
      body: Container(
//        constraints: BoxConstraints.expand(),
        height: MediaQuery.of(context).size.height -
            (MediaQuery.of(context).size.height * 0.15),
        child: Container(
          decoration: new BoxDecoration(
              color: AppColors.white,
              borderRadius: new BorderRadius.all(Radius.circular(10))),
          padding: EdgeInsets.symmetric(
              horizontal: Dimen.horizontal_padding,
              vertical: Dimen.vertical_padding),
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: (_searchResults ?? []).length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimen.vertical_padding + 10),
                    child: AppFreightCoItem(freightCoSummary: _searchResults[index],),
                  ),
                  AppHorizontalDivider(),
                ],
              );
            },
            controller: _scrollController,
            scrollDirection: Axis.vertical,
          ),
        ),
      ),
    );
  }

  Future<Null> _fetchFreightCompanies() async {
    if (_hasMoreResults) {
        _isLoading = true;

      PagedFreightCoSummary newFreightCompanies = await _freightCoService
          .search(_currentPage, _pageSize, search: _currentQuery);

      setState(() {
        _searchResults.addAll(newFreightCompanies.data);
        _hasMoreResults = newFreightCompanies.hasNext;
        _isLoading = false;
      });
    }

    return null;
  }

  void _scrollHandler() {
    // If is at the bottom, do another request
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if(!_isLoading && _hasMoreResults) {
        _currentPage += 1;
        _fetchFreightCompanies();
      }
    }
  }
}
