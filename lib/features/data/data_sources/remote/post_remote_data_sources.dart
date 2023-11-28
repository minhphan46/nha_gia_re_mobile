import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:nhagiare_mobile/core/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/query_builder.dart';
import '../../../../core/utils/typedef.dart';
import '../../../../injection_container.dart';
import '../../models/post/real_estate_post.dart';
import '../db/database_helper.dart';
import '../local/authentication_local_data_source.dart';

abstract class PostRemoteDataSrc {
  Future<HttpResponse<List<RealEstatePostModel>>> getAllPosts(String? userId);
  Future<HttpResponse<List<RealEstatePostModel>>> getPostsSearch(
      Map<String, dynamic>? query);
  Future<HttpResponse<List<RealEstatePostModel>>> getPostsStatus(String status);
  Future<HttpResponse<List<RealEstatePostModel>>> getPostsExpired();
  Future<HttpResponse<void>> createPost(RealEstatePostModel post);
  Future<HttpResponse<List<String>>> uploadImages(List<File> images);
}

class PostRemoteDataSrcImpl implements PostRemoteDataSrc {
  final Dio client;

  PostRemoteDataSrcImpl(this.client);

  @override
  Future<HttpResponse<List<RealEstatePostModel>>> getAllPosts(
      String? userId) async {
    var url = '$apiUrl$kGetPostEndpoint';
    if (userId != null) {
      url += QueryBuilder()
          .addQuery('post_user_id', Operation.equals, '\'$userId\'')
          .build();
    }
    return await DatabaseHelper().getPosts(url, client);
  }

  @override
  Future<HttpResponse<List<RealEstatePostModel>>> getPostsStatus(
      String status) async {
    String url =
        '$apiUrl$kGetPostEndpoint${QueryBuilder().addQuery('post_status', Operation.equals, '\'$status\'').addOrderBy('posted_date', OrderBy.desc).build()}';

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

  @override
  Future<HttpResponse<List<String>>> uploadImages(List<File> images) async {
    const url = '$apiUrl$kPostImages';

    // Tạo danh sách các FormData để chứa từng file
    List<FormData> formDataList = [];

    for (int i = 0; i < images.length; i++) {
      String fileName = images[i].path.split('/').last;
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(images[i].path,
            filename: 'image_${i}_$fileName.png'),
      });
      formDataList.add(formData);
    }

    // get access token
    AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
    String? accessToken = localDataSrc.getAccessToken();
    if (accessToken == null) {
      throw const ApiException(
          message: 'Access token is null', statusCode: 505);
    }

    try {
      // Gửi request POST để upload từng file
      Response response = await client.post(
        url,
        data: FormData.fromMap({
          'files': formDataList,
        }),
        options: Options(
          sendTimeout: const Duration(seconds: 10),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type':
                'multipart/form-data; boundary=<calculated when request is sent>'
          },
        ),
      );

      print(response.toString());

      // Xử lý kết quả response
      if (response.statusCode == 200) {
        List<String> imageUrls = List<String>.from(response.data['result']);
        return HttpResponse<List<String>>(
          imageUrls,
          response,
        );
      } else {
        return HttpResponse<List<String>>(
          [],
          response,
        );
      }
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<List<RealEstatePostModel>>> getPostsSearch(
      Map<String, dynamic>? query) async {
    var url = '$apiUrl$kGetPostEndpoint';
    if (query != null) {
      if (query.containsKey('isLease')) {
        url += QueryBuilder()
            .addQuery('post_is_lease', Operation.equals, query['isLease'])
            .build();
      }
    }
    return await DatabaseHelper().getPosts(url, client);
  }
}
