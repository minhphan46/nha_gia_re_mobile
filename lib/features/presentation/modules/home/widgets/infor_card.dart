import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/double_ex.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../domain/entities/posts/real_estate_post.dart';
import '../home_controller.dart';
import '../../../../../core/extensions/date_ex.dart';

class InforCard extends StatelessWidget {
  const InforCard({super.key, required this.post});

  final RealEstatePostEntity post;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      child: InkWell(
        splashColor: AppColor.green,
        child: Container(
          color: AppColor.white,
          width: 180,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: post.images!.first,
                fit: BoxFit.fill,
                height: 110,
                width: 180,
              ),
            ),
            Text(
              post.title!,
              style: AppTextStyles.semiBold12,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              double.parse(post.price!).toFormattedMoney(),
              style: AppTextStyles.medium12.copyWith(color: AppColor.orange),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              post.address.toString(),
              style: AppTextStyles.medium12.copyWith(
                  color: AppColor.grey500, overflow: TextOverflow.ellipsis),
              maxLines: 1,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              maxLines: 1,
              post.postedDate!.getTimeAgo(),
              style: AppTextStyles.medium12.copyWith(color: AppColor.grey500),
            )
          ]),
        ),
      ),
    );
  }
}

class InforCardList extends StatefulWidget {
  const InforCardList({
    super.key,
    required this.title,
    //required this.list,
    //required this.navType,
    // this.province,
    // this.uid,
  });

  final String title;
  //final List<RealEstatePostEntity> list;
  //final TypeNavigate navType;
  //final String? province;
  //final String? uid;

  @override
  State<InforCardList> createState() => _InforCardListState();
}

class _InforCardListState extends State<InforCardList> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 350),
      padding: const EdgeInsets.all(10),
      color: AppColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppTextStyles.bold14,
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(
            child: FutureBuilder<List<RealEstatePostEntity>>(
              future: controller.onGetAllPosts(),
              builder: (context, snapShot) {
                if (!snapShot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<RealEstatePostEntity> data = snapShot.data!;
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: data.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child: InforCard(key: UniqueKey(), post: data[index]),
                        onTap: () {
                          // Get.toNamed(
                          //     AppRoutes.getPostRoute(widget.list[index].id),
                          //     arguments: widget.list[index]);
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          const Divider(
            thickness: 0.5,
            height: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ZoomTapAnimation(
                child: InkWell(
                  child: Text(
                    'Xem thêm 12.345 mẫu tin khác'.tr,
                    style: AppTextStyles.regular12
                        .copyWith(color: AppColor.grey500),
                  ),
                  onTap: () {
                    // String? matchingProvince;
                    // if (widget.province != null) {
                    //   matchingProvince =
                    //       FilterValues.instance.provinces.firstWhere(
                    //     (item) => widget.province!
                    //         .noAccentVietnamese()
                    //         .contains(item.noAccentVietnamese()),
                    //   );
                    // }
                    // var data = {
                    //   "title": widget.title,
                    //   "type": widget.navType,
                    //   "province": matchingProvince,
                    //   "uid": widget.uid,
                    // };
                    // Get.toNamed(AppRoutes.resultArg, arguments: data);
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
