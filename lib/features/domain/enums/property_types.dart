enum PropertyTypes {
  apartment,
  land,
  office,
  motel,
  house;

  static PropertyTypes parse(String value) {
    for (PropertyTypes type in PropertyTypes.values) {
      if (type.toString() == value) return type;
    }
    throw Exception(
        "Can't parse PropertyTypes! Your input value is \"$value\"");
  }

  @override
  String toString() {
    switch (this) {
      case PropertyTypes.apartment:
        return "apartment";
      case PropertyTypes.land:
        return "land";
      case PropertyTypes.office:
        return "office";
      case PropertyTypes.motel:
        return "motel";
      case PropertyTypes.house:
        return "house";
    }
  }
}
