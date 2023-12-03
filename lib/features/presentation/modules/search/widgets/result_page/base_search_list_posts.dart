import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../config/theme/app_color.dart';
import '../../../../../../config/theme/text_styles.dart';
import '../../../../../../core/resources/pair.dart';
import '../../../../../domain/entities/posts/real_estate_post.dart';

class BaseSearchListPosts extends StatefulWidget {
  final Future<Pair<int, List<RealEstatePostEntity>>> Function({int? page})
      getPosts;
  final RxList<RealEstatePostEntity> postsList;
  final Widget? Function(RealEstatePostEntity post) buildItem;
  final String titleNull;
  final RxBool isLoading;
  final RxBool hasMore;

  const BaseSearchListPosts(
      {required this.getPosts,
      required this.postsList,
      required this.buildItem,
      required this.isLoading,
      required this.hasMore,
      this.titleNull = "Chưa có tin đã đăng",
      super.key});

  @override
  State<BaseSearchListPosts> createState() => _BaseListPostsState();
}

class _BaseListPostsState extends State<BaseSearchListPosts> {
  int page = 1;
  int numOfPage = 1;
  final scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      refresh();
    });
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
    if (page < numOfPage) {
      // Fetch more data and add to the list
      await widget.getPosts(page: page).then((value) {
        numOfPage = value.first;
        final newPosts = value.second;
        //widget.postsList.addAll(newPosts);
        if (newPosts.length < 10) {
          widget.hasMore.value = false;
        } else {
          widget.hasMore.value = true;
        }
      });
    } else {
      // No more pages to fetch
      widget.hasMore.value = false;
    }
  }

  Future refresh() async {
    page = 1;
    widget.hasMore.value = true;
    await widget.getPosts(page: 1).then((value) {
      numOfPage = value.first;
      //widget.postsList.value = value.second;
      numOfPage == 1
          ? widget.hasMore.value = false
          : widget.hasMore.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RefreshIndicator(
        onRefresh: refresh,
        child: widget.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : widget.postsList.isEmpty
                ? Center(
                    child: Text(
                      widget.titleNull,
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
                        return widget.hasMore.value
                            ? const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : const SizedBox(height: 20);
                      }
                    },
                  ),
      ),
    );
  }
}
