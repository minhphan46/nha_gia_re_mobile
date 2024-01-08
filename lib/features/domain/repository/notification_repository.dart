import 'package:nhagiare_mobile/core/resources/data_state.dart';

import '../../../core/resources/pair.dart';
import '../../data/models/notification.dart';

abstract class NotificationRepository {
  Future<DataState<Pair<int, List<NotificationModel>>>> getAllNotifications(
      int page);
}
