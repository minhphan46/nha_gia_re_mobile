import 'package:equatable/equatable.dart';

import '../../enums/notification_type.dart';

class NotificationEntity extends Equatable {
  final String id;
  final NotificationType type;
  final DateTime? createAt;
  final bool isRead;
  final String title;
  final String content;
  final String? image;
  final String? link;
  final dynamic data;

  const NotificationEntity({
    required this.id,
    required this.type,
    required this.isRead,
    required this.createAt,
    required this.title,
    required this.content,
    this.image,
    this.link,
    this.data,
  });

  @override
  List<Object?> get props => [id];
}
