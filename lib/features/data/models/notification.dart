import 'package:nhagiare_mobile/features/domain/entities/noti/notification.dart';

import '../../domain/enums/notification_type.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required String id,
    required NotificationType type,
    required DateTime createAt,
    required bool isRead,
    required String title,
    required String content,
    String? image,
    String? link,
    dynamic data,
  }) : super(
          id: id,
          type: type,
          createAt: createAt,
          isRead: isRead,
          title: title,
          content: content,
          image: image,
          link: link,
          data: data,
        );
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
      data: json['data'],
    );
  }
}
