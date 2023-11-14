import 'package:flutter/material.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';
import 'package:nhagiare_mobile/features/presentation/modules/user_profile/user_profile_controller.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});

  final UserProfileController controller = UserProfileController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
          title: '${controller.user!.firstName} ${controller.user!.lastName!}'),
      body: const Center(
        child: Text('User Profile Screen'),
      ),
    );
  }
}
