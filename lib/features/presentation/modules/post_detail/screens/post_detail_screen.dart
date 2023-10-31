import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/presentation/modules/post_detail/post_detail_controller.dart';

class PostDetailScreen extends StatelessWidget {
  PostDetailScreen({super.key});

  final PostDetailController controller = Get.find<PostDetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(controller.post.title!),
      ),
    );
  }
}
