import 'package:nhagiare_mobile/core/resources/pair.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/noti/notification.dart';
import '../../repository/notification_repository.dart';

class GetNotificationUseCase
    extends UseCase<Pair<int, List<NotificationEntity>>, int> {
  final NotificationRepository repository;

  GetNotificationUseCase(this.repository);

  @override
  Future<Pair<int, List<NotificationEntity>>> call({int? params}) async {
    final result = await repository.getAllNotifications(params ?? 1);
    if (result is DataSuccess) {
      return Pair(result.data!.first, result.data!.second);
    } else {
      return Pair(0, []);
    }
  }
}
