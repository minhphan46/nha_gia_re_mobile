import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/presentation/modules/blogs/blog_controller.dart';

class BlogBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlogController>(() => BlogController());
  }
}
