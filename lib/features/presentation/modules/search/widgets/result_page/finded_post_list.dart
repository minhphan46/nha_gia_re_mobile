import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';
import 'package:nhagiare_mobile/features/presentation/modules/search/widgets/result_page/base_search_list_posts.dart';
import '../../search_controller.dart';
import 'item_product.dart';

class FindedPostList extends StatefulWidget {
  final bool isLease;
  const FindedPostList({required this.isLease, super.key});

  @override
  State<FindedPostList> createState() => _FindedPostListState();
}

class _FindedPostListState extends State<FindedPostList> {
  final MySearchController searchController = Get.find<MySearchController>();

  Widget? buildItem(RealEstatePostEntity post) {
    return ItemProduct(
      post: post,
      isFavourited: post.isFavorite ?? false,
      onTap: searchController.navigateToDetailSceen,
    );
  }

  @override
  void initState() {
    searchController.initPosts(widget.isLease);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: BaseSearchListPosts(
        titleNull: "Không tìm thấy bài đăng nào",
        getPosts: ({int? page}) async {
          var value = await searchController.getPosts(page: page);
          return value;
        },
        postsList: searchController.searchPosts,
        buildItem: buildItem,
        isLoading: searchController.isLoadingGetPosts,
        hasMore: searchController.hasMore,
      ),
    );
  }
}
