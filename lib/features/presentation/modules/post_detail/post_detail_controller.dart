import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';

class PostDetailController extends GetxController {
  final RealEstatePostEntity post = Get.arguments as RealEstatePostEntity;
}
