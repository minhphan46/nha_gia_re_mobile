enum OfficeTypes {
  office,
  officetel,
  shophouse,
  comercialspace;

  static OfficeTypes parse(String value) {
    for (OfficeTypes type in OfficeTypes.values) {
      if (type.toString() == value) return type;
    }
    throw Exception("Can't parse OfficeTypes! Your input value is \"$value\"");
  }

  @override
  String toString() {
    switch (this) {
      case OfficeTypes.office:
        return "office";
      case OfficeTypes.officetel:
        return "officetel";
      case OfficeTypes.shophouse:
        return "shophouse";
      case OfficeTypes.comercialspace:
        return "comercialspace";
    }
  }
}
