import 'dart:async';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/resources/pair.dart';
import 'package:nhagiare_mobile/features/domain/entities/noti/notification.dart';
import 'package:nhagiare_mobile/injection_container.dart';
import '../../../domain/usecases/noti/get_notification_usecase.dart';

class NotificationController extends GetxController {
  int page = 1;
  int totalPage = 1;
  RxList<NotificationEntity>? listNoti;
  final getNotificationsUsecase = sl<GetNotificationUseCase>();
  Future<Pair<int, List<NotificationEntity>>> getNotifications(int page) async {
    final result = await getNotificationsUsecase(params: page);
    print("$page/${result.first}");
    return result;
  }
}
