enum FurnitureStatus {
  empty,
  basic,
  full,
  highEnd;

  static FurnitureStatus parse(String value) {
    for (FurnitureStatus status in FurnitureStatus.values) {
      if (status.toString() == value) return status;
    }
    throw Exception(
        "Can't parse FurnitureStatus! Your input value is \"$value\"");
  }

  @override
  String toString() {
    switch (this) {
      case FurnitureStatus.empty:
        return "empty";
      case FurnitureStatus.basic:
        return "basic";
      case FurnitureStatus.full:
        return "full";
      case FurnitureStatus.highEnd:
        return "high_end";
    }
  }
}
