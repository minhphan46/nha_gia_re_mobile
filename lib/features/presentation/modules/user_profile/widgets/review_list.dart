import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/core/extensions/date_ex.dart';

class Review {
  final String id;
  final String name;
  final String avatar;
  final String content;
  final DateTime date;

  const Review({
    required this.id,
    required this.name,
    required this.avatar,
    required this.content,
    required this.date,
  });
}

class ReviewGenerator {
  static final List<String> names = [
    "Hào Nguyễn",
    "Huy Nguyễn",
    "Minh Phan",
    "Hải Nguyễn",
    "Alex Phạm",
    "John Doe",
  ];

  static final List<String> avatars = [
    "https://picsum.photos/200/300?random=1",
    "https://picsum.photos/300/300?random=2",
    "https://picsum.photos/300/300?random=3",
    "https://picsum.photos/300/300?random=4",
    "https://picsum.photos/300/300?random=5",
    "https://picsum.photos/300/300?random=6",
    "https://picsum.photos/300/300?random=7",
  ];

  static final List<String> reviewContents = [
    "Dịch vụ chuyên nghiệp, tư vấn rất tận tâm. Tôi rất hài lòng với nhà môi giới này.",
    "Giao dịch diễn ra suôn sẻ, nhà môi giới giúp đỡ rất nhiệt tình.",
    "Đội ngũ nhân viên am hiểu thị trường, giúp tôi tìm được căn nhà ưng ý.",
    "Chất lượng phục vụ cao, tôi sẽ giới thiệu cho bạn bè và người thân.",
    "Giá cả hợp lý, nhà môi giới này có uy tín cao trên thị trường.",
  ];

  static Review generateRandomReview() {
    Random random = Random();

    String id = DateTime.now().millisecondsSinceEpoch.toString();
    String name = names[random.nextInt(names.length)];
    String avatar = avatars[random.nextInt(avatars.length)];
    String content = reviewContents[random.nextInt(reviewContents.length)];
    DateTime date = DateTime.now().subtract(Duration(days: random.nextInt(30)));

    return Review(
      id: id,
      name: name,
      avatar: avatar,
      content: content,
      date: date,
    );
  }

  static List<Review> generateRandomReviews(int count) {
    List<Review> reviews = [];
    for (int i = 0; i < count; i++) {
      reviews.add(generateRandomReview());
    }
    return reviews;
  }
}

class ReviewList extends StatelessWidget {
  List<Review> reviews;
  ReviewList({super.key, required this.reviews});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          Review review = reviews[index];
          return ListTile(
            key: Key(review.id),
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: CachedNetworkImageProvider(review.avatar),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review.name, style: AppTextStyles.bold14),
                  Text(
                    review.date.getTimeAgoVi(),
                    style: AppTextStyles.regular12,
                  ),
                ],
              ),
            ),
            subtitle: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  review.content,
                  style: AppTextStyles.regular14,
                )),
            // trailing: Text(
            //   "${review.date.day}/${review.date.month}/${review.date.year}",
            // ),
          );
        });
  }
}
