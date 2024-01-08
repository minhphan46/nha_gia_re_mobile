import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import 'package:nhagiare_mobile/features/domain/entities/user/user.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/loading_component.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/not_identity_card.dart';
import 'package:nhagiare_mobile/features/presentation/modules/account/account_controller.dart';
import 'package:nhagiare_mobile/features/presentation/modules/account/screens/liked_post_screen.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/values/asset_image.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final AccountController controller = Get.find();

  @override
  void initState() {
    controller.initServicePack();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          MyAppbar(title: "Tài khoản", isShowBack: false, actions: const []),
      body: FutureBuilder<UserEntity?>(
          future: controller.getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            UserEntity? user = snapshot.data;
            if (user == null) {
              return const Center(
                child: Text("Có lỗi xảy ra"),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: ListTile.divideTiles(
                  color: AppColors.grey100,
                  context: context,
                  tiles: [
                    // account
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 2),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                user.fullName,
                                style: AppTextStyles.medium16,
                              ),
                              const SizedBox(width: 2),
                              if (user.isIdentityVerified ?? false)
                                Image.asset(
                                  Assets.badge,
                                  height: 15,
                                  width: 15,
                                ),
                            ],
                          ),
                          if (!controller.isIdentity) const NotIdentityCard(),
                        ],
                      ),
                      onTap: () {
                        controller.navToAccountInfo();
                      },
                      leading: CircleAvatar(
                        radius: 18,
                        backgroundImage: user.avatar == null
                            ? const AssetImage(Assets.avatarDefault)
                                as ImageProvider
                            : CachedNetworkImageProvider(user.avatar!),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                      ),
                    ),
                    FutureBuilder<String>(
                      future: controller.checkUserIsWaiting(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          if (snapshot.error != null) {
                            return const Center(
                              child: Text("error"),
                            );
                          } else {
                            final checkStatus = snapshot.data!;
                            if (checkStatus == "2") {
                              // duyet duoc roi
                              return Container();
                            } else {
                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 2),
                                title: Text(
                                  'Xác thực danh tính',
                                  style: AppTextStyles.medium16,
                                ),
                                onTap: () {
                                  // if (checkStatus == "0") {
                                  //   //chua co
                                  //   controller.navToVerification().then((value) {
                                  //     setState(() {});
                                  //   });
                                  // } else if (checkStatus == "1") {
                                  //   // dang cho duyet
                                  //   controller.navToWaitingVerification().then((value) {
                                  //     setState(() {});
                                  //   });
                                  // } else {
                                  //   // tu choi
                                  //   controller.navToRejectVerification(snapshot.data!);
                                  // }
                                  controller.navToVerification().then((value) {
                                    setState(() {});
                                  });
                                },
                                leading: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Icon(
                                    Icons.admin_panel_settings_outlined,
                                    color: AppColors.black,
                                    size: 25,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                ),
                              );
                            }
                          }
                        }
                      },
                    ),
                    // favorite
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 2),
                      title: Text(
                        'Đã lưu',
                        style: AppTextStyles.medium16,
                      ),
                      onTap: () {
                        Get.to(() => LikedPostScreen());
                      },
                      leading: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(
                          Icons.favorite,
                          color: AppColors.red,
                          size: 25,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                      ),
                    ),
                    // purchase
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 2),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gói dịch vụ',
                            style: AppTextStyles.medium16,
                          ),
                          const SizedBox(height: 2),
                          Obx(
                            () => (controller.servicePack.value != 0)
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: controller.servicePack.value == 1
                                          ? AppColors.green100
                                          : controller.servicePack.value == 2
                                              ? AppColors.blue100
                                              : AppColors.red100,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      controller.servicePack.value == 1
                                          ? "Gói cơ bản"
                                          : controller.servicePack.value == 2
                                              ? "Gói chuyên nghiệp"
                                              : "Gói doanh nghiệp",
                                      style: AppTextStyles.medium12.colorEx(
                                          controller.servicePack.value == 1
                                              ? AppColors.green800
                                              : controller.servicePack.value ==
                                                      2
                                                  ? AppColors.blue800
                                                  : AppColors.red),
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        ],
                      ),
                      onTap: () {
                        controller.navToPurchase();
                      },
                      leading: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Image.asset(
                          Assets.archive,
                          height: 25,
                          color: AppColors.black,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                      ),
                    ),
                    // update info
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 2),
                      title: Text(
                        'Cập nhập thông tin',
                        style: AppTextStyles.medium16,
                      ),
                      onTap: () {
                        controller.navToUpdateInfo();
                      },
                      leading: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(
                          Icons.edit_outlined,
                          color: AppColors.black,
                          size: 25,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                      ),
                    ),
                    // change Password
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 2),
                      title: Text(
                        'Đổi mật khẩu',
                        style: AppTextStyles.medium16,
                      ),
                      onTap: () {},
                      leading: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(
                          Icons.lock_outline_rounded,
                          color: AppColors.black,
                          size: 25,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                      ),
                    ),
                    // change language
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 2),
                      title: Text(
                        'Ngôn ngữ',
                        style: AppTextStyles.medium16,
                      ),
                      onTap: () {},
                      leading: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(
                          Icons.language_outlined,
                          color: AppColors.black,
                          size: 25,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                      ),
                    ),
                    // logout
                    Obx(() => ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 2),
                          title: controller.isLoadingLogout.value
                              ? const LoadingComponent(color: AppColors.red)
                              : Text(
                                  'Đăng xuất',
                                  style: AppTextStyles.medium16
                                      .colorEx(AppColors.red),
                                ),
                          onTap: () {
                            controller.handleSignOut();
                          },
                          leading: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(
                              Icons.logout,
                              color: AppColors.red,
                              size: 25,
                            ),
                          ),
                        )),
                  ],
                ).toList(),
              ),
            );
          }),
    );
  }
}
