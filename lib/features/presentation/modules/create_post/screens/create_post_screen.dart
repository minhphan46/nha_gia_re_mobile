import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/create_post_controller.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/address_images_card.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/motel_area_prices_card.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/base_card.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/choose_lease_card.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/choose_type_property.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/choose_type_user.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/motel_more_info_card.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../domain/enums/property_types.dart';
import '../../../global_widgets/my_appbar.dart';
import '../widgets/motel_info_card.dart';
import '../widgets/post_info_card.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({super.key});

  final CreatePostController controller = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: MyAppbar(
        title: 'Đăng tin',
      ),
      body: ListView(
        children: [
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // choose is lease
                BaseCard(
                  title: "Loại bài đăng",
                  isvisible: true,
                  child: ChooseLeaseCard(),
                ),
                // card choose type property
                BaseCard(
                  title: "Loại bất động sản",
                  isvisible: true,
                  child: ChooseTypePropertyCard(),
                ),
                // card choose type of user
                Obx(
                  () => BaseCard(
                    title: "Bạn là",
                    isvisible: controller.selectedPropertyType.value != null,
                    child: ChooseTypeUserCard(),
                  ),
                ),
                // post info card
                Obx(
                  () => BaseCard(
                    title: "Thông tin bài đăng",
                    isvisible: controller.selectedPropertyType.value != null,
                    child: PostInfoCard(),
                  ),
                ),
                Obx(
                  () => BaseCard(
                    title: "Địa chỉ & Hình ảnh",
                    isvisible: controller.selectedPropertyType.value != null,
                    child: AddressImagesCard(),
                  ),
                ),

                // Motel ======================================================
                Obx(
                  () => BaseCard(
                    title: "Thông tin chi tiết",
                    isvisible: controller.selectedPropertyType.value != null &&
                        controller.selectedPropertyType.value ==
                            PropertyTypes.motel,
                    child: MotelInfoCard(),
                  ),
                ),
                Obx(
                  () => BaseCard(
                    title: "Diện tích & Giá",
                    isvisible: controller.selectedPropertyType.value != null &&
                        controller.selectedPropertyType.value ==
                            PropertyTypes.motel,
                    child: MotelAreaPricesCard(),
                  ),
                ),
                Obx(
                  () => BaseCard(
                    title: "Thông tin khác",
                    isvisible: controller.selectedPropertyType.value != null &&
                        controller.selectedPropertyType.value ==
                            PropertyTypes.motel,
                    child: MotelMoreInfoCard(),
                  ),
                ),

                // van phong ban

                // van phong cho thue

                // dat ban

                // dat cho thue

                // nha ban

                // nha cho thue

                // chung cu ban

                // chung cu cho thue

                // dang bai
                Obx(
                  () => Visibility(
                    visible: controller.selectedPropertyType.value != null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () {
                                controller.createPost();
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.green,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          textStyle: const TextStyle(color: AppColors.white),
                          elevation: 10,
                          minimumSize: Size(100.wp, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ))
                            : Text(
                                'Đăng bài'.tr,
                                style: AppTextStyles.bold14
                                    .colorEx(AppColors.white),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
