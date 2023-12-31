import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/utils/typedef.dart';
import '../../models/post/real_estate_post.dart';

class DatabaseHelper {
  Future<HttpResponse<Pair<int, List<RealEstatePostModel>>>> getPosts(
      String url, Dio client) async {
    try {
      print(url);
      final response = await client.get(url);
      if (response.statusCode != 200) {
        throw ApiException(
          message: response.data,
          statusCode: response.statusCode!,
        );
      }

      final int numOfPages = response.data["num_of_pages"];

      final List<DataMap> taskDataList =
          List<DataMap>.from(response.data["result"]);

      List<RealEstatePostModel> posts = [];
      for (var element in taskDataList) {
        try {
          posts.add(RealEstatePostModel.fromJson(element));
        } catch (error) {
          error.printInfo();
        }
      }

      final value = Pair(numOfPages, posts);

      return HttpResponse(value, response);
    } on ApiException {
      rethrow;
    } catch (error) {
      error.printError();
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }
}
