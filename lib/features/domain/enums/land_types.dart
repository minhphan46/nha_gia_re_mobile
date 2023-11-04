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

  static String getStringVi(LandTypes types) {
    switch (types) {
      case LandTypes.residential:
        return "Đất dân cư";
      case LandTypes.commercial:
        return "Đất thương mại";
      case LandTypes.industrial:
        return "Đất công nghiệp";
      case LandTypes.agricultural:
        return "Đất nông nghiệp";
    }
  }
}
