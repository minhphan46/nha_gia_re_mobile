import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/domain/entities/user/user.dart';

class UserProfileController extends GetxController {
  UserEntity? user = Get.arguments;

  int numberPost = 122;
  int numberFollower = 332;
  int numberFollowing = 94;
  
  bool isFollow = false;
}
