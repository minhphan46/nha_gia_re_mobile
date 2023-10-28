enum ApartmentTypes {
  apartment,
  duplex,
  officetel,
  service,
  dormitory,
  penhouse;

  static ApartmentTypes parse(String value) {
    for (ApartmentTypes type in ApartmentTypes.values) {
      if (type.toString() == value) return type;
    }
    throw Exception(
        "Can't parse ApartmentTypes! Your input value is \"$value\"");
  }

  @override
  String toString() {
    switch (this) {
      case ApartmentTypes.apartment:
        return "apartment";
      case ApartmentTypes.duplex:
        return "duplex";
      case ApartmentTypes.officetel:
        return "officetel";
      case ApartmentTypes.service:
        return "service";
      case ApartmentTypes.dormitory:
        return "dormitory";
      case ApartmentTypes.penhouse:
        return "penhouse";
    }
  }
}
