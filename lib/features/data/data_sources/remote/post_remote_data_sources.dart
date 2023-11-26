import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:nhagiare_mobile/core/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/typedef.dart';
import '../../../../injection_container.dart';
import '../../models/post/real_estate_post.dart';
import '../db/database_helper.dart';
import '../local/authentication_local_data_source.dart';

abstract class PostRemoteDataSrc {
  Future<HttpResponse<List<RealEstatePostModel>>> getAllPosts(String? userId);
  Future<HttpResponse<List<RealEstatePostModel>>> getPostsApproved();
  Future<HttpResponse<List<RealEstatePostModel>>> getPostsHided();
  Future<HttpResponse<List<RealEstatePostModel>>> getPostsPending();
  Future<HttpResponse<List<RealEstatePostModel>>> getPostsRejected();
  Future<HttpResponse<List<RealEstatePostModel>>> getPostsExpired();
  Future<HttpResponse<void>> createPost(RealEstatePostModel post);
}

class PostRemoteDataSrcImpl implements PostRemoteDataSrc {
  final Dio client;

  PostRemoteDataSrcImpl(this.client);

  @override
  Future<HttpResponse<List<RealEstatePostModel>>> getAllPosts(
      String? userId) async {
    var url = '$apiUrl$kGetPostEndpoint';
    if (userId != null) url += '?post_user_id[eq]=\'$userId\'';
    return await DatabaseHelper().getPosts(url, client);
  }

  @override
  Future<HttpResponse<List<RealEstatePostModel>>> getPostsApproved() async {
    const status = 'approved';
    const url = '$apiUrl$kGetPostEndpoint?post_status[eq]=\'$status\'';

    return await DatabaseHelper().getPosts(url, client);
  }

  @override
  Future<HttpResponse<List<RealEstatePostModel>>> getPostsExpired() async {
    const url = '$apiUrl$kGetPostEndpoint';

    try {
      final response = await client.get(url);
      //print('${response.statusCode} : ${response.data["message"].toString()}');
      if (response.statusCode != 200) {
        //print('${response.statusCode} : ${response.data["result"].toString()}');
        throw ApiException(
          message: response.data,
          statusCode: response.statusCode!,
        );
      }

      final List<DataMap> taskDataList =
          List<DataMap>.from(response.data["result"]);

      List<RealEstatePostModel> value = taskDataList
          .map((postJson) => RealEstatePostModel.fromJson(postJson))
          //.where((post) => post.isActive!)
          //.where((post) => post.expiryDate!.isBefore(DateTime.now()))
          .toList();

      return HttpResponse(value, response);
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<List<RealEstatePostModel>>> getPostsHided() async {
    const status = 'hided';
    const url = '$apiUrl$kGetPostEndpoint?post_status[eq]=\'$status\'';

    return await DatabaseHelper().getPosts(url, client);
  }

  @override
  Future<HttpResponse<List<RealEstatePostModel>>> getPostsPending() async {
    const status = 'pending';
    const url = '$apiUrl$kGetPostEndpoint?post_status[eq]=\'$status\'';
    return await DatabaseHelper().getPosts(url, client);
  }

  @override
  Future<HttpResponse<List<RealEstatePostModel>>> getPostsRejected() async {
    const status = 'rejected';
    const url = '$apiUrl$kGetPostEndpoint?post_status[eq]=\'$status\'';

    return await DatabaseHelper().getPosts(url, client);
  }

  @override
  Future<HttpResponse<void>> createPost(RealEstatePostModel postModel) async {
    const url = '$apiUrl$kCreatePostEndpoint';
    try {
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw const ApiException(
            message: 'Access token is null', statusCode: 505);
      }

      // Gửi yêu cầu đến server
      print(postModel.toJson());

      final response = await client.post(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
        data: postModel.toJson(),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          message: response.data['message'],
          statusCode: response.statusCode!,
        );
      }

      // Nếu yêu cầu thành công, giải mã dữ liệu JSON

      final DataMap data = DataMap.from(response.data["result"]);

      return HttpResponse(null, response);
    } on DioException catch (e) {
      throw ApiException(
        message: e.message!,
        statusCode: e.response?.statusCode ?? 505,
      );
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }
}
