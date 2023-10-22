import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/routes/app_routes.dart';
import 'package:nhagiare_mobile/features/presentation/modules/account/account_binding.dart';
import 'package:nhagiare_mobile/features/presentation/modules/account/screens/account_screen.dart';
import 'package:nhagiare_mobile/features/presentation/modules/bottom_bar/bottom_bar_binding.dart';
import 'package:nhagiare_mobile/features/presentation/modules/bottom_bar/bottom_bar_screen.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/create_post_binding.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/screens/create_post_screen.dart';
import 'package:nhagiare_mobile/features/presentation/modules/home/home_binding.dart';
import 'package:nhagiare_mobile/features/presentation/modules/home/screens/home_screen.dart';
import 'package:nhagiare_mobile/features/presentation/modules/login/login_binding.dart';
import 'package:nhagiare_mobile/features/presentation/modules/login/screens/login_screen.dart';
import 'package:nhagiare_mobile/features/presentation/modules/login/screens/register_screen.dart';
import 'package:nhagiare_mobile/features/presentation/modules/notification/notification_binding.dart';
import 'package:nhagiare_mobile/features/presentation/modules/notification/screens/notification_screen.dart';
import 'package:nhagiare_mobile/features/presentation/modules/post_management/post_management_binding.dart';
import 'package:nhagiare_mobile/features/presentation/modules/post_management/screens/post_management_screen.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.bottomBar,
      page: () => const BottomBarScreen(),
      binding: BottomBarBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.postManagement,
      page: () => const PostManagementScreen(),
      binding: PostManagementBinding(),
    ),
    GetPage(
      name: AppRoutes.createPost,
      page: () => const CreatePostScreen(),
      binding: CreatePostBinding(),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationScreen(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: AppRoutes.account,
      page: () => const AccountScreen(),
      binding: AccountBinding(),
    ),
  ];
}
