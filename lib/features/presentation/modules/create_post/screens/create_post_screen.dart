import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/create_post_controller.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/choose_type_property.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/choose_type_user.dart';

import '../../../global_widgets/my_appbar.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({super.key});

  final CreatePostController controller = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: const MyAppbar(
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
                ChooseTypePropertyCard(),
                // card choose type of user
                ChooseTypeUserCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
