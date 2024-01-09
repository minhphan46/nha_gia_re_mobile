enum NotificationType {
  postApproved,
  postRejected,
  postWarningExpired,
  postDeleted,
  follow,
  news,
  info,
  chat;

  @override
  String toString() {
    switch (this) {
      case NotificationType.postApproved:
        return "post_approved";
      case NotificationType.postRejected:
        return "post_rejected";
      case NotificationType.postWarningExpired:
        return "post_warning_expired";
      case NotificationType.postDeleted:
        return "post_deleted";
      case NotificationType.follow:
        return "follow";
      case NotificationType.news:
        return "news";
      case NotificationType.info:
        return "info";
      case NotificationType.chat:
        return "chat";
    }
  }

  static NotificationType parse(String value) {
    for (NotificationType type in NotificationType.values) {
      if (type.toString() == value) return type;
    }
    throw Exception(
        "Can't parse NotificationType! Your input value is \"$value\"");
  }
}
