import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
      case NotificationType.info:
        return AppColors.green100;
      case NotificationType.warning:
        return AppColors.yellow100;
      default:
        return AppColors.green;
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
            // side: const BorderSide(
            //   color: AppColors.grey200,
            //   width: 1,
            // ),
          ),
          onTap: () {
            // Get.toNamed('/notification-detail', arguments: notiModel);
          },
          splashColor: AppColors.grey200,
          leading: notiModel.image == null
              ? const Icon(
                  Icons.circle_notifications,
                  color: AppColors.green,
                  size: 50,
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    height: 100,
                    width: 100,
                    imageUrl: notiModel.image!,
                    fit: BoxFit.cover,
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
                  notiModel.type.toString().split('.').last,
                  style: AppTextStyles.medium12,
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notiModel.title,
                style: !notiModel.isRead
                    ? AppTextStyles.semiBold14
                    : AppTextStyles.regular14,
              ),
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
