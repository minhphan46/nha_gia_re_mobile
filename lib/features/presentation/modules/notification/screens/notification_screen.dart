import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/values/asset_image.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../data/models/notification.dart';
import '../notification_controller.dart';
import '../widgets/NotificationItem.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController _controller = Get.find<NotificationController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông báo"),
      ),
      body: StreamBuilder<List<NotificationModel>>(
        stream: _controller.notificationStream.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              return const Center(
                child: Text('An error occured'),
              );
            } else {
              var data = snapshot.data!;

              if (data.isEmpty) {
                return Center(
                    child: SingleChildScrollView(
                  child: SvgPicture.asset(Assets.emptyNotification),
                ));
              }

              return Container(
                color: AppColors.grey100,
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, i) {
                    NotificationModel noti = snapshot.data![i];
                    return NotificationListItem(notiModel: noti);
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
