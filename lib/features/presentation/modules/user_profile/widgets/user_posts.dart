import 'package:flutter/material.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import '../../../../domain/entities/posts/real_estate_post.dart';
import '../../../global_widgets/infor_card.dart';

class UserPosts extends StatelessWidget {
  final List<RealEstatePostEntity> data;
  const UserPosts({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 28.hp,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          shrinkWrap: false,
          children: data
              .map((post) => InkWell(
                    child: InforCard(
                      key: UniqueKey(),
                      post: post,
                      width: 50.wp,
                    ),
                  ))
              .toList(),
        ));
  }
}
