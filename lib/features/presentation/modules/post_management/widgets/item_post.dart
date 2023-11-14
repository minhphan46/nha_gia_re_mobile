import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';
import 'package:nhagiare_mobile/features/domain/enums/post_status_management.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';

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
        return AppColors.green;
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap(widget.post);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 8),
        color: AppColors.white,
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
                  const SizedBox(width: 5),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.status,
                          style: AppTextStyles.medium14
                              .copyWith(color: getColorStatus()),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.post.title!,
                          style: AppTextStyles.medium14.copyWith(
                            color: AppColors.grey700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(widget.post.address.toString(),
                            style: AppTextStyles.regular12.copyWith(
                              color: AppColors.grey500,
                            )),
                      ],
                    ),
                  ),
                  // column text
                  const SizedBox(width: 8),
                ],
              ),
            ),
            // more icon
            PopupMenuButton<int>(
              initialValue: selectedMenu,
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
