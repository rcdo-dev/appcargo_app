import 'package:flutter/widgets.dart';

import 'app_loading_widget.dart';

typedef PageResolver<T> = Future<List<T>> Function(
    int pageSize, int pageNumber);
typedef LoadMoreButtonBuilder = Widget Function(
    BuildContext ctx, Function onClick);
typedef ItemBuilder<T> = Widget Function(BuildContext, T);

// based on https://medium.com/@KarthikPonnam/flutter-loadmore-in-listview-23820612907d
class PageableListView<T> extends StatefulWidget {
  final int pageSize;
  final LoadMoreButtonBuilder loadMoreButtonBuilder;
  final ItemBuilder<T> itemBuilder;
  final PageResolver<T> pageResolver;
  final WidgetBuilder whenEmpty;

  PageableListView(
    this.pageResolver,
    this.itemBuilder,
    this.loadMoreButtonBuilder, {
    this.pageSize = 15,
    this.whenEmpty,
  });

  @override
  State<StatefulWidget> createState() {
    return _PageableListViewState<T>();
  }
}

class _PageableListViewState<T> extends State<PageableListView<T>> {
  int _pageNumber = 0;
  int _lastQuantityFetched = 0;
  List<T> _items = List<T>();
  Future _currentFuture;

  @override
  void initState() {
    super.initState();
    this.requestNextPage();
  }

  void requestNextPage() {
    if (null == _currentFuture) {
      setState(() {
        int nextPageNum = _pageNumber + 1;
        _currentFuture = widget
            .pageResolver(widget.pageSize, nextPageNum)
            .then(this.onReady);
        _pageNumber = nextPageNum;
      });
    }
  }

  void onReady(List<T> list) {
    setState(() {
      _items.addAll(list);
      _currentFuture = null;
      _lastQuantityFetched = list.length;
    });
  }

  bool get canLoadMore =>
      null == _lastQuantityFetched || _lastQuantityFetched < widget.pageSize;

  @override
  Widget build(BuildContext context) {
    return null == _currentFuture && (null == _items || _items.isEmpty) && null != widget.whenEmpty
        ? widget.whenEmpty(context)
        : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: (_lastQuantityFetched < widget.pageSize)
                ? _items.length
                : _items.length + 1,
            itemBuilder: (context, index) {
              if (index != _items.length) {
                return widget.itemBuilder(context, _items[index]);
              }

              if (null != _currentFuture) {
                return AppLoadingWidget();
              }

              if (canLoadMore) {
                return widget.loadMoreButtonBuilder(
                    context, this.requestNextPage);
              }

              return null;
            },
          );
  }
}
