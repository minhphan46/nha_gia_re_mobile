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
        return 'post_price';
      case priceDesc:
        return 'post_price';
      case createdAtAsc:
        return 'posted_date';
      case createdAtDesc:
        return 'posted_date';
      case relatedAsc:
        return '';
      case relatedDesc:
        return '';
      case nearByAsc:
        return '';
      case nearByDesc:
        return '';
      default:
        return '';
    }
  }
  //(this == priceAsc || this == priceDesc) ? 'price' : 'posted_date';

  bool get isAsc =>
      this == priceAsc ||
      this == createdAtAsc ||
      this == relatedAsc ||
      this == nearByAsc;
}
