import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/values/asset_image.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../domain/entities/noti/notification.dart';
import '../notification_controller.dart';
import '../widgets/notificationItem.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController _controller = Get.find<NotificationController>();

  int page = 0;
  int totalPage = 1;
  RxBool isLoading = RxBool(false);
  Rx<List<NotificationEntity>?> listNoti = Rx<List<NotificationEntity>?>(null);
  final ScrollController _scrollController = ScrollController();
  void _loadMore() async {
    page++;
    isLoading.value = true;
    final result = await _controller.getNotifications(page);
    // listNoti.addAll(result.second);
    if (listNoti.value == null) {
      listNoti.value = result.second.obs;
    } else {
      listNoti.value!.addAll(result.second);
    }
    totalPage = result.first;
    isLoading.value = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMore();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print(page < totalPage);
        if (page < totalPage) {
          _loadMore();
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông báo"),
      ),
      body: Obx(
        () {
          return (listNoti.value == null)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (listNoti.value!.isEmpty)
                  ? Center(
                      child: SingleChildScrollView(
                      child: SvgPicture.asset(Assets.emptyNotification),
                    ))
                  : Container(
                      color: AppColors.grey100,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: listNoti.value!.length,
                        itemBuilder: (_, i) {
                          // return NotificationListItem(
                          //     notiModel: listNoti.value![i]);

                          if (i == listNoti.value!.length) {
                            if (page < totalPage) {
                              print("loading");
                              return Visibility(
                                visible: isLoading.value,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              print("end");
                              return const SizedBox();
                            }
                          } else {
                            return NotificationListItem(
                                notiModel: listNoti.value![i]);
                          }
                        },
                      ),
                    );
        },
      ),
    );
  }
}
