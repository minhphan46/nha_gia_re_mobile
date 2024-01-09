enum VerificationStatus {
  notSent,
  pending,
  verified,
  rejected;

  static VerificationStatus parse(String value) {
    for (VerificationStatus type in VerificationStatus.values) {
      if (type.toString() == value) return type;
    }
    throw Exception(
        "Can't parse VerificationStatus! Your input value is \"$value\"");
  }

  static VerificationStatus parseVi(String value) {
    for (VerificationStatus type in VerificationStatus.values) {
      if (getStringVi(type) == value) return type;
    }
    throw Exception(
        "Can't parse VerificationStatus! Your input value is \"$value\"");
  }

  @override
  String toString() {
    switch (this) {
      case VerificationStatus.notSent:
        return "not_sent";
      case VerificationStatus.pending:
        return "pending";
      case VerificationStatus.verified:
        return "verified";
      case VerificationStatus.rejected:
        return "rejected";
    }
  }

  static String getStringVi(VerificationStatus type) {
    switch (type) {
      case VerificationStatus.notSent:
        return "Chưa gửi";
      case VerificationStatus.pending:
        return "Đang chờ";
      case VerificationStatus.verified:
        return "Đã xác thực";
      case VerificationStatus.rejected:
        return "Đã từ chối";
    }
  }
}
