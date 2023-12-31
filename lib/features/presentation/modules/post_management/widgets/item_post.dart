import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';
import 'package:nhagiare_mobile/features/domain/enums/post_status_management.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';

class ItemPost extends StatefulWidget {
  final RealEstatePostEntity post;
  final PostStatusManagement statusCode;
  final String status;
  final List<String> funcs;
  final List<IconData> iconFuncs;
  final Function onSelectedMenu;
  final Function onTap;

  const ItemPost({
    required this.statusCode,
    required this.status,
    required this.post,
    required this.funcs,
    required this.iconFuncs,
    required this.onSelectedMenu,
    required this.onTap,
    super.key,
  });

  @override
  State<ItemPost> createState() => _ItemPostState();
}

class _ItemPostState extends State<ItemPost> {
  double sizeImage = 80;

  int selectedMenu = 0;
  Color getColorStatus() {
    switch (widget.statusCode) {
      case PostStatusManagement.approved:
        return AppColors.green800;
      case PostStatusManagement.pending:
        return AppColors.blue800;
      case PostStatusManagement.rejected:
        return AppColors.red800;
      case PostStatusManagement.hided:
        return AppColors.grey700;
      case PostStatusManagement.exprired:
        return AppColors.yellow800;
    }
  }

  Color getColorBackground() {
    switch (widget.statusCode) {
      case PostStatusManagement.approved:
        return AppColors.green100;
      case PostStatusManagement.pending:
        return AppColors.blue100;
      case PostStatusManagement.rejected:
        return AppColors.red100;
      case PostStatusManagement.hided:
        return AppColors.grey100;
      case PostStatusManagement.exprired:
        return AppColors.yellow100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap(widget.post);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.grey300,
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // image
                  SizedBox(
                    height: sizeImage,
                    width: sizeImage,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: widget.post.images!.isEmpty
                          ? Image.asset(
                              Assets.defaultImage,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: widget.post.images!.isNotEmpty
                                  ? widget.post.images![0]
                                  : "",
                              fit: BoxFit.cover,
                              errorWidget: (context, error, stackTrace) {
                                return Image.asset(
                                  Assets.defaultImage,
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
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: getColorBackground(),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            widget.status,
                            style: AppTextStyles.medium12
                                .copyWith(color: getColorStatus()),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.post.title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.medium14.copyWith(
                            color: AppColors.grey700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.post.address!.getDetailAddress(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.regular12.copyWith(
                            color: AppColors.grey500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // more icon
            PopupMenuButton<int>(
              initialValue: selectedMenu,
              icon: const Icon(
                Icons.more_vert,
                color: AppColors.grey300,
              ),
              color: AppColors.white,
              // Callback that sets the selected popup menu item.
              onSelected: (int item) {
                setState(() {
                  selectedMenu = item;
                  widget.onSelectedMenu(item, widget.post);
                });
              },
              itemBuilder: (BuildContext context) =>
                  widget.funcs.asMap().entries.map(
                (e) {
                  int i = e.key;
                  String val = e.value;
                  return PopupMenuItem<int>(
                    value: i,
                    child: Row(
                      children: [
                        Icon(widget.iconFuncs[i]),
                        const SizedBox(width: 15),
                        Text(val),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
