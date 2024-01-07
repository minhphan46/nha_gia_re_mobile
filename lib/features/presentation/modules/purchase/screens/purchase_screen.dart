import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:nhagiare_mobile/config/routes/app_routes.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/core/extensions/date_ex.dart';
import 'package:nhagiare_mobile/core/extensions/double_ex.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/features/domain/entities/purchase/transaction.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';
import 'package:nhagiare_mobile/features/presentation/modules/purchase/widgets/package_card.dart';
import '../../../../../config/theme/app_color.dart';
import '../purchase_controller.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen>
    with TickerProviderStateMixin {
  final PurchaseController controller = Get.find<PurchaseController>();
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: MyAppbar(
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(
              text: "Tất cả",
            ),
            Tab(
              text: "Gói hiện tại",
            ),
            Tab(
              text: "Lịch sử",
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Get.to(PurchaseHistoryScreen());
            },
            icon: const Icon(Icons.history),
          )
        ],
        title: 'Gói dịch vụ',
      ),
      body: FutureBuilder<PurchaseState>(
          future: controller.getPurchaseState(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            PurchaseState purchaseState = snapshot.data!;
            return TabBarView(
              controller: tabController,
              children: [
                SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        height: 50.0.hp,
                        width: double.infinity,
                        foregroundDecoration: BoxDecoration(
                          color: AppColors.black.withOpacity(0.7),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: "https://picsum.photos/200/300?random=1",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Nhà giá rẻ",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            const Text(
                              "Giải pháp chuyên nghiệp dành cho các nhà Môi giới Bất động sản",
                              style: TextStyle(
                                color: AppColors.white,
                              ),
                            ),
                            const Text(
                              "Tiết kiệm - Tiện lợi - Hiệu quả",
                              style: TextStyle(
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ...purchaseState.membershipPackages
                                .map((e) => Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      width: double.infinity,
                                      child: MembershipPackageCard(
                                        isShowButton:
                                            purchaseState.currentSubscription ==
                                                null,
                                        package: e,
                                        onButtonClick: (package) {
                                          Get.toNamed(
                                              AppRoutes.purchaseChoosePlan,
                                              arguments: package);
                                        },
                                        buttonText: "Mua ngay",
                                      ),
                                    )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                purchaseState.currentSubscription == null
                    ? const Center(
                        child: Text("Bạn chưa đăng ký gói nào"),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MembershipPackageCard(
                            package:
                                purchaseState.currentSubscription!.package!,
                            isShowButton: true,
                            buttonColor: AppColors.red,
                            buttonText: "Hủy gói",
                            onButtonClick: (package) async {
                              final res = await controller.unsubscribe();
                              if (res) {
                                Get.snackbar(
                                  "Hủy gói thành công",
                                  "Bạn đã hủy gói thành công",
                                  backgroundColor: AppColors.green,
                                  colorText: AppColors.white,
                                );

                                // Refresh
                                setState(() {});
                              } else {
                                Get.snackbar(
                                  "Hủy gói thất bại",
                                  "Đã có lỗi xảy ra, vui lòng thử lại sau",
                                  backgroundColor: AppColors.red,
                                  colorText: AppColors.white,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                purchaseState.transactions.isEmpty
                    ? const Text("Bạn chưa có giao dịch nào")
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: purchaseState.transactions.length,
                        itemBuilder: (context, index) {
                          TransactionEntity transaction =
                              purchaseState.transactions[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                                border: Border.all(
                                  color: AppColors.grey100,
                                )),
                            child: ListTile(
                              leading: const Icon(
                                HeroiconsSolid.creditCard,
                                color: AppColors.green,
                              ),
                              title: Text(
                                "${transaction.package!.name} ${transaction.numOfSubscriptionMonth} tháng",
                                style: AppTextStyles.semiBold16,
                              ),
                              subtitle: Text(
                                "Thời gian giao dịch:\n${transaction.timestamp.toHMDMYString()}",
                                style: AppTextStyles.regular14,
                              ),
                              trailing: Text(
                                "${transaction.amount.formatNumberWithCommas}đ",
                                style: AppTextStyles.semiBold14.copyWith(
                                  color: AppColors.orange,
                                ),
                              ),
                            ),
                          );
                        },
                      )
              ],
            );
          }),
    );
  }
}
