import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/create_post_controller.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/address_images_card.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/area_prices_card.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/base_card.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/choose_lease_card.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/choose_type_property.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/choose_type_user.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/more_info_card.dart';
import '../../../global_widgets/my_appbar.dart';
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

                // phong tro

                // van phong ban

                // van phong cho thue

                // dat ban

                // dat cho thue

                // nha ban

                // nha cho thue

                // chung cu ban

                // chung cu cho thue
                Obx(
                  () => BaseCard(
                    title: "Thông tin chi tiết",
                    isvisible: controller.selectedPropertyType.value != null,
                    child: PostInfoCard(),
                  ),
                ),
                Obx(
                  () => BaseCard(
                    title: "Diện tích & Giá",
                    isvisible: controller.selectedPropertyType.value != null,
                    child: AreaPricesCard(),
                  ),
                ),
                Obx(
                  () => BaseCard(
                    title: "Thông tin khác",
                    isvisible: controller.selectedPropertyType.value != null,
                    child: MoreInfoCard(),
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
