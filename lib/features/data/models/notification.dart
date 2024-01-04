enum NotificationType {
  suggest,
  expirationWarning,
  rejectPost,
  acceptPost,
  newFollower,
  advertise;

  @override
  String toString() {
    switch (this) {
      case NotificationType.suggest:
        return "suggest";
      case NotificationType.expirationWarning:
        return "expirationWarning";
      case NotificationType.rejectPost:
        return "rejectPost";
      case NotificationType.acceptPost:
        return "acceptPost";
      case NotificationType.advertise:
        return "advertise";
      case NotificationType.newFollower:
        return "newFollower";
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

class NotificationModel {
  String id;
  NotificationType type;
  DateTime? createAt;
  bool isRead;
  String title;
  String content;
  String? image;
  String? link;

  NotificationModel({
    required this.id,
    required this.type,
    required this.isRead,
    required this.createAt,
    required this.title,
    required this.content,
    this.image,
    this.link,
  });

  void setIsRead(bool check) {
    isRead = check;
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      type: NotificationType.parse(json['type']),
      createAt: DateTime.now(),
      isRead: json['is_read'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
      link: json['link'],
    );
  }
}
