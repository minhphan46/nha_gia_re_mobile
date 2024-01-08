enum NotificationType {
  info,
  warning,
  message;

  @override
  String toString() {
    switch (this) {
      case NotificationType.info:
        return 'info';
      case NotificationType.warning:
        return 'warning';
      case NotificationType.message:
        return 'message';
      default:
        return 'info';
    }
  }

  static NotificationType parse(String value) {
    for (NotificationType type in NotificationType.values) {
      if (type.toString() == value) {
        return type;
      }
    }
    throw Exception(
        "Can't parse NotificationType! Your input value is \"$value\"");
  }
}
