enum HouseTypes {
  townhouse,
  villa,
  alleyhouse,
  frontagehouse;

  static HouseTypes parse(String value) {
    for (HouseTypes type in HouseTypes.values) {
      if (type.toString() == value) return type;
    }
    throw Exception("Can't parse HouseTypes! Your input value is \"$value\"");
  }

  @override
  String toString() {
    switch (this) {
      case HouseTypes.townhouse:
        return "townhouse";
      case HouseTypes.villa:
        return "villa";
      case HouseTypes.alleyhouse:
        return "alleyhouse";
      case HouseTypes.frontagehouse:
        return "frontagehouse";
    }
  }
}
