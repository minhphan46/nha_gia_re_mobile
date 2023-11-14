import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/features/domain/entities/blog.dart';
import 'package:nhagiare_mobile/features/domain/usecases/blog/remote/get_all_blogs.dart';
import 'package:nhagiare_mobile/injection_container.dart';

class BlogController extends GetxController {
  final GetBlogsUseCase getBlogsUseCase = sl.get<GetBlogsUseCase>();
  Future<List<BlogEntity>> getBlogs() async {
    final result = await getBlogsUseCase.call();
    if (result is DataSuccess) {
      return result.data!;
    } else {
      return [];
    }
  }
}
