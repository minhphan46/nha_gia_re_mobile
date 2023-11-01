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
        return "Nhà phố";
      case HouseTypes.villa:
        return "Biệt thự";
      case HouseTypes.alleyhouse:
        return "Nhà hẻm";
      case HouseTypes.frontagehouse:
        return "Nhà mặt tiền";
    }
  }

  static String getStringVi(HouseTypes type) {
    switch (type) {
      case HouseTypes.townhouse:
        return "Nhà phố";
      case HouseTypes.villa:
        return "Biệt thự";
      case HouseTypes.alleyhouse:
        return "Nhà hẻm";
      case HouseTypes.frontagehouse:
        return "Nhà mặt tiền";
    }
  }
}
