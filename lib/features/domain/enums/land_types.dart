enum LandTypes {
  residential,
  commercial,
  industrial,
  agricultural;

  static LandTypes parse(String value) {
    for (LandTypes type in LandTypes.values) {
      if (type.toString() == value) return type;
    }
    throw Exception("Can't parse LandTypes! Your input value is \"$value\"");
  }

  @override
  String toString() {
    switch (this) {
      case LandTypes.residential:
        return "residential";
      case LandTypes.commercial:
        return "commercial";
      case LandTypes.industrial:
        return "industrial";
      case LandTypes.agricultural:
        return "agricultural";
    }
  }
}