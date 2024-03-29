import 'package:nhagiare_mobile/features/data/models/blog/blog_model.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:nhagiare_mobile/core/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/typedef.dart';

abstract class BlogRemoteDataSrc {
  Future<HttpResponse<List<BlogModel>>> getAllBlogs();
}

class BlogRemoteDataSrcImpl implements BlogRemoteDataSrc {
  final Dio client;

  BlogRemoteDataSrcImpl(this.client);

  @override
  Future<HttpResponse<List<BlogModel>>> getAllBlogs() {
    final url = '$apiAppUrl$kGetBlogEndpoint' + '?is_active[eq]=true';

    try {
      return client.get(url).then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }

        final List<DataMap> taskDataList =
            List<DataMap>.from(response.data["result"]);

        List<BlogModel> value = taskDataList
            .map((postJson) => BlogModel.fromJson(postJson))
            .toList();

        return HttpResponse(value, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }
}
