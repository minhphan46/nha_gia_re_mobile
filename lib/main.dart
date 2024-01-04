import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/routes/app_pages.dart';
import 'package:nhagiare_mobile/config/routes/app_routes.dart';
import 'package:nhagiare_mobile/config/values/app_string.dart';
import 'package:nhagiare_mobile/injection_container.dart';
import 'config/theme/app_theme.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ansiColorDisabled = false;
  await initializeDependencies();
  OneSignal.initialize('f8ec53cc-0f67-482a-8a58-09ebba348a1a');
  OneSignal.Notifications.requestPermission(true).then((value) {
    print(value);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // khong cho man hinh xoay ngang
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      defaultTransition: Transition.cupertino,
      initialRoute: AppRoutes.splashScreen,
      getPages: AppPages.pages,
    );
  }
}
