import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/routes/app_routes.dart';
import 'package:nhagiare_mobile/core/resources/pair.dart';
import 'package:nhagiare_mobile/core/utils/check_time_date.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/get_posts.dart';
import 'package:nhagiare_mobile/features/presentation/modules/search/widgets/my_search_delegate.dart';
import 'package:nhagiare_mobile/injection_container.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/resources/data_state.dart';
import '../../../domain/entities/posts/filter_request.dart';
import '../../../domain/enums/navigate_type.dart';
import '../../../domain/enums/posted_by.dart';
import '../../../domain/usecases/post/remote/get_post_search.dart';

class HomeController extends GetxController {
  String nameUser = "Minh Phan";

  RxInt unreadMessCount = 1.obs;
  RxInt unreadNotiCount = 1.obs;

  // appbar
  Greeting getGreeting() {
    return CheckTimeOfDate.getGreeting();
  }

  // Search
  var textSearchController = TextEditingController();
  var searchFocusNode = FocusNode();

  onTapSearch(BuildContext context, MySearchDelegate delegate) async {
    await showSearch<String>(
      context: context,
      delegate: delegate,
    );
  }

  onChangedTextFiled(String value) {}

  // image ad
  final List<String> imgList = [
    'https://cdn.chotot.com/admincentre/D7Le2XZDgAF07oJDVyc_Gz765rWVQ5c8hwXonwYWapg/preset:raw/plain/a54ed308183c261c8529a6729ef4512c-2812912165257461362.jpg',
    'https://cdn.chotot.com/admincentre/ctc6HtBG1QICBtN5KQNCNO34k73kZn9gQLxmhOjfWw4/preset:raw/plain/1bfd526b0b6c995da1c20eb5f3ba0c51-2805772162331331393.jpg',
    'https://cdn.chotot.com/admincentre/ICGqIPhBAn559vSI4v7jaBAYFYegeRG7xSfUJ6tkugI/preset:raw/plain/6ec3994f81e14d768dfc467847ce430c-2820195948173896828.jpg',
    'https://cdn.chotot.com/admincentre/83O9GjTqqxMohxXA1DcGEojtznUAIxJYWwTDMhhWp88/preset:raw/plain/bb0f1e32befe115598c292f0b7434fe7-2829010373569559918.jpg',
    'https://cdn.chotot.com/admincentre/586665ff-021b-4eb2-a0a2-acf2405ebedc_banner.jpg',
  ];
  final String fakeUrl = 'https://flutter.dev';

  void launchWebURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  // near by
  List<String> locationNearby = [
    "Hà Nội",
    "Hồ Chí Minh",
    "Đà Nẵng",
    "Hải Phòng",
    "Cần Thơ",
    "An Giang",
  ];

  // get all posts
  final GetPostsUseCase _getPostsUseCase = sl<GetPostsUseCase>();
  final GetPostSearchsUseCase getPostSearchsUseCase =
      sl<GetPostSearchsUseCase>();
  Future<List<RealEstatePostEntity>> getAllPosts({int? page}) async {
    final dataState = await _getPostsUseCase(params: Pair(null, page));

    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      return dataState.data!.second;
    } else if (dataState is DataFailed) {
      return [];
    } else {
      return [];
    }
  }

  Future<List<RealEstatePostEntity>> getPostsNearBy({int? page}) async {
    PostFilter postFilter = PostFilter(
      postedBy: PostedBy.all,
      provinceCode: 1,
    );
    final dataState =
        await getPostSearchsUseCase(params: Pair(postFilter, page));

    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      return dataState.data!.second;
    } else if (dataState is DataFailed) {
      return [];
    } else {
      return [];
    }
  }

  Future<List<RealEstatePostEntity>> getPostsRent({int? page}) async {
    PostFilter postFilter = PostFilter(
      isLease: true,
      postedBy: PostedBy.all,
      provinceCode: 0,
    );
    final dataState =
        await getPostSearchsUseCase(params: Pair(postFilter, page));

    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      return dataState.data!.second;
    } else if (dataState is DataFailed) {
      return [];
    } else {
      return [];
    }
  }

  Future<List<RealEstatePostEntity>> getPostsSell({int? page}) async {
    PostFilter postFilter = PostFilter(
      isLease: false,
      postedBy: PostedBy.all,
      provinceCode: 0,
    );
    final dataState =
        await getPostSearchsUseCase(params: Pair(postFilter, page));

    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      return dataState.data!.second;
    } else if (dataState is DataFailed) {
      return [];
    } else {
      return [];
    }
  }

  // navigate to notification screen
  void navigateToNotificationScreen() {
    Get.toNamed(AppRoutes.notifications);
  }

  void navigateToChatScreen() {
    Get.toNamed(AppRoutes.chat);
  }

  void navigateToCreatePostScreen() {
    Get.toNamed(AppRoutes.createPost);
  }

  void navToSell() {
    var data = {
      "title": "Cần bán",
      "type": TypeNavigate.sell,
    };
    Get.toNamed(AppRoutes.resultArg, arguments: data);
  }

  void navToRent() {
    var data = {
      "title": "Cho thuê",
      "type": TypeNavigate.rent,
    };
    Get.toNamed(AppRoutes.resultArg, arguments: data);
  }

  void navByProvince(String provider) {
    var data = {
      "title": 'Tỉnh thành',
      "type": TypeNavigate.province,
      "province": provider,
    };
    Get.toNamed(AppRoutes.resultArg, arguments: data);
  }
}
