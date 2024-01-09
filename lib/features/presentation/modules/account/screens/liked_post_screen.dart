import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/presentation/modules/account/account_controller.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../domain/entities/posts/real_estate_post.dart';
import '../../post_management/widgets/base_list_posts.dart';
import '../../search/widgets/result_page/item_product.dart';

// ignore: must_be_immutable
class LikedPostScreen extends StatefulWidget {
  const LikedPostScreen({super.key});

  @override
  State<LikedPostScreen> createState() => _LikedPostScreenState();
}

class _LikedPostScreenState extends State<LikedPostScreen> {
  final AccountController controller = Get.find<AccountController>();

  Widget? buildItem(RealEstatePostEntity post) {
    return ItemProduct(
      post: post,
      isFavourited: post.isFavorite ?? false,
      onTap: (RealEstatePostEntity post) async {
        Get.toNamed(AppRoutes.postDetail, arguments: post)!
            .then((value) => setState(() {
                  controller.getPostFavorite();
                }));
      },
    );
  }

  @override
  void initState() {
    controller.getPostFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bài đăng đã thích"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BaseListPosts(
          titleNull: "Chưa có tin đã thích",
          getPosts: controller.getPostFavorite,
          postsList: controller.favoritePosts,
          buildItem: buildItem,
        ),
      ),
    );
  }
}
