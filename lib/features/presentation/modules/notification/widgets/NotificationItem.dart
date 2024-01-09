import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:nhagiare_mobile/core/extensions/date_ex.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../domain/entities/noti/notification.dart';
import '../../../../domain/enums/notification_type.dart';

class NotificationListItem extends StatelessWidget {
  final NotificationEntity notiModel;

  const NotificationListItem({
    required this.notiModel,
    super.key,
  });

  Color getColorStatus() {
    switch (notiModel.type) {
      case NotificationType.postApproved:
      case NotificationType.info:
      case NotificationType.follow:
      case NotificationType.news:
      case NotificationType.acceptAccountVerificationRequest:
        return AppColors.green100;
      case NotificationType.postRejected:
      case NotificationType.postDeleted:
      case NotificationType.rejectAccountVerificationRequest:
        return AppColors.red100;
      case NotificationType.postWarningExpired:
        return AppColors.yellow100;
      default:
        return AppColors.green;
    }
  }

  String getType() {
    switch (notiModel.type) {
      case NotificationType.postApproved:
        return 'Đã duyệt';
      case NotificationType.postRejected:
        return 'Bị từ chối';
      case NotificationType.postDeleted:
        return 'Bị xóa';
      case NotificationType.postWarningExpired:
        return 'Hết hạn';
      case NotificationType.info:
        return 'Thông báo';
      case NotificationType.follow:
        return 'Theo dõi';
      case NotificationType.news:
        return 'Tin tức';
      case NotificationType.acceptAccountVerificationRequest:
      case NotificationType.rejectAccountVerificationRequest:
        return 'Xác minh tài khoản';
      default:
        return 'Thông báo';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              // delete task
            },
            icon: Icons.delete,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          onTap: () {
            // Get.toNamed('/notification-detail', arguments: notiModel);
          },
          splashColor: AppColors.grey200,
          leading: notiModel.image == null
              ? const Icon(
                  HeroiconsMini.bell,
                  color: AppColors.green,
                  size: 50,
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    imageUrl: notiModel.image!,
                    errorWidget: (context, error, stackTrace) {
                      return const Icon(
                        Icons.circle_notifications,
                        color: AppColors.green,
                        size: 50,
                      );
                    },
                    progressIndicatorBuilder:
                        (context, string, loadingProgress) {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.progress,
                        ),
                      );
                    },
                  ),
                ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: getColorStatus(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  getType(),
                  style: AppTextStyles.medium12,
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(notiModel.title, style: AppTextStyles.semiBold14),
              Text(
                notiModel.content,
                style: AppTextStyles.regular12,
              ),
              Visibility(
                visible: notiModel.createAt != null,
                child: Text(
                  notiModel.createAt!.getTimeAgoVi(),
                  style: AppTextStyles.regular12,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
