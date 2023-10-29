import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../domain/entities/posts/real_estate_post.dart';
import '../home_controller.dart';
import 'infor_card.dart';

class InforCardList extends StatelessWidget {
  final String title;
  final Function getListFunc;
  InforCardList({
    super.key,
    required this.title,
    required this.getListFunc,
  });

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 35.hp),
      color: AppColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.bold14,
          ),
          const SizedBox(height: 10),
          Flexible(
            child: FutureBuilder<List<RealEstatePostEntity>>(
              future: getListFunc(),
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
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ZoomTapAnimation(
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.only(
                      bottom: 2, // space between underline and text
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColor.grey500, // Text colour here
                          width: 0.5, // Underline width
                        ),
                      ),
                    ),
                    child: Text(
                      'Xem thêm 12.345 mẫu tin khác'.tr,
                      style: AppTextStyles.regular12.copyWith(
                        color: AppColor.grey500,
                        //decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
