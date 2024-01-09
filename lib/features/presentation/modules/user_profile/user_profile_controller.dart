import 'dart:io';

import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/resources/pair.dart';
import 'package:nhagiare_mobile/features/domain/entities/user/report.dart';
import 'package:nhagiare_mobile/features/domain/entities/user/user.dart';
import 'package:nhagiare_mobile/features/domain/usecases/user/FollowOrUnfollowUserUseCase.dart';
import 'package:nhagiare_mobile/features/domain/usecases/user/GetFollowersAndFollowingsCount.dart';
import 'package:nhagiare_mobile/features/domain/usecases/user/send_report.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../injection_container.dart';
import '../../../domain/entities/posts/real_estate_post.dart';
import '../../../domain/enums/report_enums.dart';
import '../../../domain/usecases/authentication/get_user_id.dart';
import '../../../domain/usecases/post/remote/get_posts.dart';
import '../../../domain/usecases/post/remote/upload_images.dart';

class UserProfileController extends GetxController {
  UserEntity? user = Get.arguments;
  RxBool isFollow = false.obs;
  late RxBool isMe = false.obs;

  RxString numOfPosts = "-".obs;

  GetUserIdUseCase getUserIdUseCase = sl<GetUserIdUseCase>();
  Future<void> checkIsMe() async {
    isMe.value = (user!.id == await getUserIdUseCase());
    print(isMe.value);
  }

  // get all posts
  final GetPostsUseCase _getPostsUseCase = sl<GetPostsUseCase>();
  Future<List<RealEstatePostEntity>> getAllPosts({int? page = 1}) async {
    final dataState = await _getPostsUseCase(
      params: Pair(user!.id, page),
    );

    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      numOfPosts.value = dataState.data!.second.length.toString();
      return dataState.data!.second;
    } else if (dataState is DataFailed) {
      return [];
    } else {
      return [];
    }
  }

  final GetFollowersAndFollowingsCount _getFollowersAndFollowingsCountUseCase =
      sl<GetFollowersAndFollowingsCount>();

  Future<Pair<int, int>> getFollowersAndFollowingsCount() async {
    try {
      final data =
          await _getFollowersAndFollowingsCountUseCase(params: user!.id!);
      return data;
    } catch (e) {
      Get.snackbar("Lỗi", "Lỗi khi lấy dữ liệu");
      return Pair(0, 0);
    }
  }

  void navToAccountInfo() {
    Get.toNamed(AppRoutes.updateInfoAccount, arguments: user);
  }

  RxBool isShowReport = false.obs;
  SendReportUsecase sendReportUsecase = sl<SendReportUsecase>();
  Future<void> handleReportUser(
      UserEntity user, String reason, File image) async {
    isShowReport.value = false;
    String urlImage = await uploadImages(image);
    ReportEntity reportEntity = ReportEntity(
      reportedId: user.id,
      contentType: ReportContentType.inappropriate,
      description: reason,
      type: ReportType.user,
      images: [urlImage],
    );

    await sendReportUsecase(params: reportEntity);
    Get.snackbar("Thông báo", "Báo cáo thành công");
    isShowReport.value = false;
  }

  UploadImagessUseCase uploadImagessUseCase = sl<UploadImagessUseCase>();
  Future<String> uploadImages(File image) async {
    final dataState = await uploadImagessUseCase(params: [image]);

    if (dataState is DataSuccess) {
      return dataState.data![0];
    } else {
      return "";
    }
  }

  final FollowOrUnfollowUserUseCase _followOrUnfollowUserUseCase =
      sl<FollowOrUnfollowUserUseCase>();
  Future<void> followOrUnfollow() async {
    final dataState = await _followOrUnfollowUserUseCase(params: user!.id!);
    isFollow.value = dataState;
    print(isFollow.value);
  }
}
