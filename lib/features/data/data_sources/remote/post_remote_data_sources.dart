import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:nhagiare_mobile/core/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/typedef.dart';
import '../../models/post/real_estate_post.dart';

abstract class PostRemoteDataSrc {
  Future<HttpResponse<List<RealEstatePostModel>>> getAllPosts();
}

class PostRemoteDataSrcImpl implements PostRemoteDataSrc {
  final Dio client;

  PostRemoteDataSrcImpl(this.client);

  @override
  Future<HttpResponse<List<RealEstatePostModel>>> getAllPosts() async {
    const url = '$apiBaseUrl/posts';

    try {
      final response = await client.get(url);
      print('${response.statusCode} : ${response.data["message"].toString()}');
      if (response.statusCode != 200) {
        print('${response.statusCode} : ${response.data["result"].toString()}');
        throw ApiException(
          message: response.data,
          statusCode: response.statusCode!,
        );
      }

      final List<DataMap> taskDataList =
          List<DataMap>.from(response.data["result"]);

      List<RealEstatePostModel> value = taskDataList
          .map((postJson) => RealEstatePostModel.fromJson(postJson))
          .toList();

      return HttpResponse(value, response);
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }
}
