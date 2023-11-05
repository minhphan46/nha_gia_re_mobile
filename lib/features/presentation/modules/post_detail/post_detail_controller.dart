import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';
import 'package:nhagiare_mobile/features/presentation/modules/post_detail/widgets/motel_card.dart';
import 'package:nhagiare_mobile/features/presentation/modules/post_detail/widgets/office_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../injection_container.dart';
import '../../../domain/entities/properties/apartment.dart';
import '../../../domain/entities/properties/house.dart';
import '../../../domain/entities/properties/land.dart';
import '../../../domain/entities/properties/motel.dart';
import '../../../domain/entities/properties/office.dart';
import '../../../domain/entities/properties/property_feature.dart';
import '../../../domain/usecases/post/remote/get_posts.dart';
import 'widgets/apartment_card.dart';
import 'widgets/house_card.dart';
import 'widgets/land_card.dart';

class PostDetailController extends GetxController {
  final RealEstatePostEntity post = Get.arguments as RealEstatePostEntity;
  PropertyFeature? feature;
  late bool isYourPost = false;

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
  final GetPostsUseCase _getPostsUseCase = sl<GetPostsUseCase>();
  Future<List<RealEstatePostEntity>> getRelatePosts() async {
    final dataState = await _getPostsUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      return dataState.data!;
    } else if (dataState is DataFailed) {
      return [];
    } else {
      return [];
    }
  }

  void likePost() async {
    // PostRepository postRepo = GetIt.instance<PostRepository>();
    // if (!liked.value && !isLoading) {
    //   isLoading = true;
    //   await postRepo.likePost(post.id).then((value) {
    //     liked.value = true;
    //     numOfLikes.value++;
    //     isLoading = false;
    //   });
    // } else if (liked.value && !isLoading) {
    //   isLoading = true;
    //   await postRepo.unlikePost(post.id).then((value) {
    //     liked.value = false;
    //     numOfLikes.value--;
    //     isLoading = false;
    //   });
    // }
  }

  void navToChat() {
    //Get.toNamed(AppRoutes.chat, arguments: userInfo);
  }

  void navToUserProfile() {
    //Get.toNamed(AppRoutes.personal, arguments: userInfo);
  }

  void launchPhone() {
    launchUrl(Uri.parse("tel://${0899922463}"));
  }

  void launchSms() {
    launchUrl(Uri.parse("sms://${0899922463}"));
  }
}