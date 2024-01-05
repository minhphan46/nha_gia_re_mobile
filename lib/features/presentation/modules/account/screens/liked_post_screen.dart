import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/presentation/modules/account/account_controller.dart';

import '../../../../domain/entities/posts/real_estate_post.dart';
import '../../user_profile/widgets/user_posts.dart';

class LikedPostScreen extends StatelessWidget {
  LikedPostScreen({super.key});

  final AccountController controller = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bài đăng đã lưu"),
      ),
      body: FutureBuilder<List<RealEstatePostEntity>>(
          future: controller.getAllPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return UserPosts(data: snapshot.data ?? []);
          }),
    );
  }
}
