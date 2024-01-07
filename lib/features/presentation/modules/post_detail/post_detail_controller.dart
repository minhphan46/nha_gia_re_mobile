import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/resources/pair.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';
import 'package:nhagiare_mobile/features/domain/enums/order_by_types.dart';
import 'package:nhagiare_mobile/features/domain/enums/posted_by.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/like_post.dart';
import 'package:nhagiare_mobile/features/presentation/modules/post_detail/widgets/motel_card.dart';
import 'package:nhagiare_mobile/features/presentation/modules/post_detail/widgets/office_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../injection_container.dart';
import '../../../domain/entities/posts/filter_request.dart';
import '../../../domain/entities/properties/apartment.dart';
import '../../../domain/entities/properties/house.dart';
import '../../../domain/entities/properties/land.dart';
import '../../../domain/entities/properties/motel.dart';
import '../../../domain/entities/properties/office.dart';
import '../../../domain/entities/properties/property_feature.dart';
import '../../../domain/usecases/authentication/get_user_id.dart';
import '../../../domain/usecases/post/remote/get_post_search.dart';
import 'widgets/apartment_card.dart';
import 'widgets/house_card.dart';
import 'widgets/land_card.dart';

class PostDetailController extends GetxController {
  final RealEstatePostEntity post = Get.arguments as RealEstatePostEntity;
  PropertyFeature? feature;
  late RxBool isYourPost = false.obs;
  RxBool isLiked = false.obs;
  RxBool isLoading = false.obs;

  GetUserIdUseCase getUserIdUseCase = sl<GetUserIdUseCase>();
  @override
  void onInit() async {
    print(post.isFavorite);
    if (post.user!.id == await getUserIdUseCase()) {
      isYourPost.value = true;
    }
    isLiked.value = post.isFavorite!;
    super.onInit();
  }

  int getNumOfFeaturesNotNull() {
    int count = 0;
    for (var i in post.features!.values) {
      if (i != null) {
        count++;
      }
    }
    return count;
  }

  Widget getDetailCard() {
    feature = PropertyFeature.fromJson(post.typeId!, post.features!);
    if (feature is Apartment) {
      return ApartmentCard(feature: feature as Apartment);
    } else if (feature is House) {
      return HouseCard(feature: feature as House);
    } else if (feature is Land) {
      return LandCard(feature: feature as Land);
    } else if (feature is Office) {
      return OfficeCard(feature: feature as Office);
    } else if (feature is Motel) {
      return MotelCard(feature: feature as Motel);
    } else {
      return const SizedBox();
    }
  }

  // get all posts
  final GetPostSearchsUseCase getPostSearchsUseCase =
      sl<GetPostSearchsUseCase>();
  Future<List<RealEstatePostEntity>> getRelatePosts({int? page}) async {
    final dataState =
        await getPostSearchsUseCase(params: Pair(getPostFilter(), page));

    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      return dataState.data!.second;
    } else if (dataState is DataFailed) {
      return [];
    } else {
      return [];
    }
  }

  PostFilter getPostFilter() {
    return PostFilter(
      textSearch: post.title,
      orderBy: OrderByTypes.relatedDesc,
      postedBy: PostedBy.all,
    );
  }

  LikePostUseCase likePostUseCase = sl<LikePostUseCase>();
  void likePost() async {
    if (!isLiked.value && !isLoading.value) {
      isLoading.value = true;
      await likePostUseCase(params: post.id).then((value) {
        isLiked.value = value.data!;
        isLoading.value = false;
      });
    } else if (isLiked.value && !isLoading.value) {
      isLoading.value = true;
      await likePostUseCase(params: post.id).then((value) {
        isLiked.value = value.data!;
        isLoading.value = false;
      });
    }
  }

  void navToChat() {
    Get.toNamed(AppRoutes.chatDetail, arguments: post.user);
  }

  void navToUserProfile() {
    Get.toNamed(AppRoutes.userProfile, arguments: post.user);
  }

  void launchPhone() {
    launchUrl(Uri.parse("tel://${post.user!.phone}"));
  }

  void launchSms() {
    launchUrl(Uri.parse("sms://${post.user!.phone}"));
  }

  void navToEditPost() {
    Get.toNamed(AppRoutes.createPost, arguments: post);
  }
}
