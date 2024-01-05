import 'package:nhagiare_mobile/features/domain/entities/posts/limit_post.dart';

class LitmitPostModel extends LitmitPostEntity {
  const LitmitPostModel({
    super.isExceeded,
    super.limitPostInMonth,
    super.countPostInMonth,
  });

  factory LitmitPostModel.fromJson(Map<String, dynamic> json) {
    return LitmitPostModel(
      isExceeded: json['isExceeded'],
      limitPostInMonth: json['limit_post_in_month'],
      countPostInMonth: json['count_post_in_month'],
    );
  }

  // from entity
  factory LitmitPostModel.fromEntity(LitmitPostEntity entity) {
    return LitmitPostModel(
      isExceeded: entity.isExceeded,
      limitPostInMonth: entity.limitPostInMonth,
      countPostInMonth: entity.countPostInMonth,
    );
  }
}
