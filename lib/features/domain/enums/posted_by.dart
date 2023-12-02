enum PostedBy {
  all,
  proSeller,
  individual;

  List<bool> toFilterList() {
    switch (this) {
      case PostedBy.all:
        return [true, false];
      case PostedBy.proSeller:
        return [true];
      case PostedBy.individual:
        return [false];
    }
  }
}
