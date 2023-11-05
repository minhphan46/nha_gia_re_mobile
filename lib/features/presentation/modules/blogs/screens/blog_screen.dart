import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/theme/app_color.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/core/extensions/double_ex.dart';
import 'package:nhagiare_mobile/features/domain/entities/blog.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';
import 'package:nhagiare_mobile/features/presentation/modules/blogs/blog_controller.dart';
import 'package:nhagiare_mobile/features/presentation/modules/blogs/screens/blog_detail_screen.dart';

class BlogListScreen extends StatefulWidget {
  const BlogListScreen({super.key});

  @override
  State<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  late final BlogController _controller;

  @override
  void initState() {
    _controller = Get.put(BlogController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        title: 'Blogs',
        isShowBack: false,
      ),
      body: FutureBuilder<List<Blog>>(
          future: _controller.getBlogs(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            RxList<Blog> data = snapshot.data!.obs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 4, 4),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: InkWell(
                      onTap: () {
                        // Get.toNamed(
                        //   "AppRoutes.blog_screen_detail",
                        //   arguments: data[index],
                        // );
                        Get.to(() => const BlogDetailScreen(),
                            arguments: data[index]);
                      },
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Container(
                            height: 70.0.wp,
                            width: 100.0.wp,
                            foregroundDecoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                // stops: [0, 0.2, 0.8, 1],
                              ),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: data[index].thumbnail,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  data[index].title,
                                  style: AppTextStyles.semiBold18
                                      .copyWith(color: AppColors.white),
                                  maxLines: 3,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  data[index].shortDescription,
                                  style: AppTextStyles.regular16
                                      .copyWith(color: AppColors.white),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: AppColors.grey100,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Obx(() => Text(
                                          "${data[index].view} lượt xem",
                                          style: AppTextStyles.regular12
                                              .copyWith(
                                                  color: AppColors.grey100),
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 4),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
