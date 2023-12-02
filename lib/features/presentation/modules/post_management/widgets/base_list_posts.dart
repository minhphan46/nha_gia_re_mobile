import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/presentation/modules/post_management/widgets/item_post.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../core/resources/pair.dart';
import '../../../../../core/utils/ansi_color.dart';
import '../../../../domain/entities/posts/real_estate_post.dart';

class BaseListPosts extends StatefulWidget {
  final Future<Pair<int, List<RealEstatePostEntity>>> Function({int? page})
      getPosts;
  final RxList<RealEstatePostEntity> postsList;
  final ItemPost Function(RealEstatePostEntity post) buildItem;
  const BaseListPosts(
      {required this.getPosts,
      required this.postsList,
      required this.buildItem,
      super.key});

  @override
  State<BaseListPosts> createState() => _BaseListPostsState();
}

class _BaseListPostsState extends State<BaseListPosts> {
  RxBool isLoading = false.obs;
  int page = 1;
  int numOfPage = 1;
  final scrollController = ScrollController();
  RxBool hasMore = true.obs;

  @override
  void initState() {
    refresh();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        fetchMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future fetchMore() async {
    page++;
    if (page <= numOfPage) {
      await widget.getPosts(page: page).then((value) {
        numOfPage = value.first;
        final newPosts = value.second;
        widget.postsList.addAll(newPosts);
      });
    } else {
      hasMore.value = false;
    }

    print(success(hasMore.value.toString()));
  }

  Future refresh() async {
    isLoading.value = true;
    page = 1;
    hasMore.value = true;
    await widget.getPosts().then((value) {
      numOfPage = value.first;
      widget.postsList.value = value.second;
    });
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: Obx(
        () => isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : widget.postsList.isEmpty
                ? Center(
                    child: Text(
                      "Chưa có tin đã đăng",
                      style:
                          AppTextStyles.bold20.copyWith(color: AppColors.green),
                    ),
                  )
                : ListView.builder(
                    controller: scrollController,
                    itemCount: widget.postsList.length + 1,
                    itemBuilder: (context, index) {
                      if (index < widget.postsList.length) {
                        return widget.buildItem(widget.postsList[index]);
                      } else {
                        return Obx(
                          () => hasMore.value
                              ? const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : const SizedBox(height: 20),
                        );
                      }
                    },
                  ),
      ),
    );
  }
}
