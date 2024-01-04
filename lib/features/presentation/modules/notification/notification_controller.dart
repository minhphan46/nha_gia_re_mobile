import 'dart:async';

import 'package:get/get.dart';

import '../../../data/models/notification.dart';

class NotificationController extends GetxController {
  List<NotificationModel> dummy = [
    NotificationModel(
      id: '1',
      type: NotificationType.acceptPost,
      isRead: false,
      createAt: DateTime.now(),
      title: 'title',
      content: "content",
    )
  ];

  // Stream<List<NotificationModel>>? notificationStream;
  StreamController<List<NotificationModel>> notificationStream =
      StreamController<List<NotificationModel>>();

  void init() {
    // notificationStream = notiRepo.getNotificationStream();
    Future.delayed(const Duration(seconds: 3), () {
      notificationStream.sink.add(dummy);
    });
  }
}
