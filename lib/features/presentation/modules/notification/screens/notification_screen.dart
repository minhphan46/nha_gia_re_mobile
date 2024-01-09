import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/values/asset_image.dart';
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
        // print(page < totalPage);
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
                  : ListView.builder(
                      controller: _scrollController,
                      // children: [
                      //   ...listNoti.value!.map((e) => NotificationListItem(
                      //         notiModel: e,
                      //       )),
                      //   Visibility(
                      //     visible: isLoading.value,
                      //     child: Center(
                      //       child: Container(
                      //         margin: const EdgeInsets.symmetric(vertical: 20),
                      //         child: const CircularProgressIndicator(),
                      //       ),
                      //     ),
                      //   ),
                      // ],
                      itemCount: listNoti.value!.length + 1,
                      itemBuilder: (context, index) {
                        if (index < listNoti.value!.length) {
                          return NotificationListItem(
                            notiModel: listNoti.value![index],
                          );
                        } else {
                          return Visibility(
                            visible: isLoading.value,
                            child: Center(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: const CircularProgressIndicator(),
                              ),
                            ),
                          );
                        }
                      },
                    );
        },
      ),
    );
  }
}
