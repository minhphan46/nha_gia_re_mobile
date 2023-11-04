import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/create_post_controller.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/address_images_card.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/base_card.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/choose_type_property.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/choose_type_user.dart';
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
                // card choose type property
                BaseCard(
                  title: "Loại bất động sản",
                  isvisible: true,
                  child: ChooseTypePropertyCard(),
                ),
                // card choose type of user
                BaseCard(
                  title: "Bạn là",
                  isvisible: true,
                  child: ChooseTypeUserCard(),
                ),
                // post info card
                BaseCard(
                  title: "Thông tin bài đăng",
                  isvisible: true,
                  child: PostInfoCard(),
                ),
                BaseCard(
                  title: "Địa chỉ & Hình ảnh",
                  isvisible: true,
                  child: AddressImagesCard(),
                ),
                BaseCard(
                  title: "Thông tin chi tiết",
                  isvisible: true,
                  child: PostInfoCard(),
                ),
                BaseCard(
                  title: "Diện tích & Giá",
                  isvisible: true,
                  child: PostInfoCard(),
                ),
                BaseCard(
                  title: "Thông tin khác",
                  isvisible: true,
                  child: PostInfoCard(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
