class PagedResponse<T> {
  int recordsTotal;
  int recordsFiltered;

  bool hasNext;
  bool hasPrevious;

  List<T> data;
}
