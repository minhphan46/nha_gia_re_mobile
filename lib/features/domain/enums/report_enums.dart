enum ReportType {
  user,
  post;

  //toString
  @override
  String toString() {
    switch (this) {
      case ReportType.user:
        return "user";
      case ReportType.post:
        return "post";
    }
  }
}

enum ReportContentType {
  spam,
  offensive,
  inappropriate,
  other;

  //toString
  @override
  String toString() {
    switch (this) {
      case ReportContentType.spam:
        return "spam";
      case ReportContentType.offensive:
        return "offensive";
      case ReportContentType.inappropriate:
        return "inappropriate";
      case ReportContentType.other:
        return "other";
    }
  }
}
