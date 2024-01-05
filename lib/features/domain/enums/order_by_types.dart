enum OrderByTypes {
  priceAsc,
  priceDesc,
  createdAtAsc,
  createdAtDesc,
  relatedAsc,
  relatedDesc,
  nearByAsc,
  nearByDesc;

  String get filterString {
    switch (this) {
      case priceAsc:
        return 'price';
      case priceDesc:
        return 'price';
      case createdAtAsc:
        return 'posted_date';
      case createdAtDesc:
        return 'posted_date';
      case relatedAsc:
        return 'display_priority_point';
      case relatedDesc:
        return 'display_priority_point';
      case nearByAsc:
        return 'display_priority_point';
      case nearByDesc:
        return 'display_priority_point';
      default:
        return 'display_priority_point';
    }
  }
  //(this == priceAsc || this == priceDesc) ? 'price' : 'posted_date';

  bool get isAsc =>
      this == priceAsc ||
      this == createdAtAsc ||
      this == relatedAsc ||
      this == nearByAsc;
}
