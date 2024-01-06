import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';

import '../../../../../../config/theme/app_color.dart';
import '../../../../../../config/theme/text_styles.dart';
import '../../../../../../config/values/app_values.dart';

class ItemProduct extends StatefulWidget {
  final RealEstatePostEntity post;
  final bool isFavourited;
  final Function onTap;

  const ItemProduct({
    super.key,
    required this.post,
    required this.isFavourited,
    required this.onTap,
  });

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  double sizeImage = 100;
  bool isLoading = false;
  // Future<void> toggleFav() async {
  //   PostRepository postRepo = GetIt.instance<PostRepository>();
  //   if (!widget.isFavourited && !isLoading) {
  //     isLoading = true;
  //     await postRepo.likePost(widget.post.id).then((value) {
  //       setState(() {
  //         widget.isFavourited = true;
  //         isLoading = false;
  //       });
  //     });
  //   } else if (widget.isFavourited && !isLoading) {
  //     isLoading = true;
  //     await postRepo.unlikePost(widget.post.id).then((value) {
  //       setState(() {
  //         widget.isFavourited = false;
  //         isLoading = false;
  //       });
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.grey300,
          width: 0.5,
        ),
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              widget.onTap(widget.post);
            },
            child: Row(
              children: [
                // image
                SizedBox(
                  height: sizeImage,
                  width: sizeImage,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: widget.post.images![0],
                      fit: BoxFit.cover,
                      errorWidget: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/default_image.png",
                          fit: BoxFit.cover,
                        );
                      },
                      progressIndicatorBuilder: (ctx, str, prc) {
                        return Center(
                          child: CircularProgressIndicator(
                            value: prc.progress,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title
                      Text(
                        widget.post.title ?? "Không có tiêu đề",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.regular14,
                      ),
                      const SizedBox(height: 5),
                      // money
                      Text(
                        "${widget.post.price!} VNĐ",
                        style: AppTextStyles.semiBold14
                            .copyWith(color: AppColors.orange),
                      ),
                      // size
                      const SizedBox(height: 5),
                      Text(
                        "${FormatNum.formatter.format(widget.post.area!.toInt())} m2",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.regular12
                            .copyWith(color: AppColors.grey500),
                      ),
                      const SizedBox(height: 5),
                      // time + location
                      Row(
                        children: [
                          Text(
                            DateFormat(FormatDate.numbericDateFormat)
                                .format(widget.post.postedDate!),
                            style: AppTextStyles.regular12
                                .copyWith(color: AppColors.grey500),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "•",
                            style: AppTextStyles.regular12
                                .copyWith(color: AppColors.grey500),
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            width: 40.wp,
                            child: Text(
                              widget.post.address!.getProvinceNames(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.regular12
                                  .copyWith(color: AppColors.grey500),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // heart
          Visibility(
            visible: false,
            child: Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  //toggleFav();
                },
                child: SizedBox(
                  child: widget.isFavourited
                      ? const Icon(
                          Icons.favorite_sharp,
                          color: AppColors.red,
                        )
                      : const Icon(Icons.favorite_border_rounded),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
