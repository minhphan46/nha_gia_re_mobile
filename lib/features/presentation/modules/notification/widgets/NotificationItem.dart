import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

  final double sizeImage = 80;

  Color getColorStatus() {
    switch (notiModel.type) {
      case NotificationType.info:
        return AppColors.grey100;
      case NotificationType.warning:
        return AppColors.yellow;
      default:
        return AppColors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // notiModel.isRead = true;
      },
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) async {
                // delete task
              },
              icon: Icons.delete,
              backgroundColor: AppColors.red,
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          tileColor: !notiModel.isRead
              ? const Color.fromARGB(255, 250, 245, 227)
              : AppColors.white,
          leading: SizedBox(
            height: sizeImage,
            width: sizeImage,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: notiModel.image == null
                  ? const Icon(
                      Icons.circle_notifications,
                      color: AppColors.green,
                      size: 50,
                    )
                  : CachedNetworkImage(
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
          ),
          title: Text(
            notiModel.type.toString().tr,
            style: AppTextStyles.semiBold12.copyWith(color: getColorStatus()),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notiModel.title,
                style: !notiModel.isRead
                    ? AppTextStyles.bold16
                    : AppTextStyles.regular16,
              ),
              const SizedBox(height: 5),
              Text(
                notiModel.content,
                style: AppTextStyles.regular14.copyWith(
                  color: const Color(0xff49454F),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
