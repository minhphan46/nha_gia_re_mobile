import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:nhagiare_mobile/core/utils/ansi_color.dart';
import 'package:retrofit/retrofit.dart';
import 'package:nhagiare_mobile/core/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/extensions/file_ex.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/utils/query_builder.dart';
import '../../../../core/utils/typedef.dart';
import '../../../../injection_container.dart';
import '../../../domain/entities/posts/filter_request.dart';
import '../../models/post/real_estate_post.dart';
import '../db/database_helper.dart';
import '../local/authentication_local_data_source.dart';
import 'package:path/path.dart';

abstract class PostRemoteDataSrc {
  Future<HttpResponse<Pair<int, List<RealEstatePostModel>>>> getAllPosts(
      String? userId, int? page);
  Future<HttpResponse<Pair<int, List<RealEstatePostModel>>>> getPostsSearch(
      PostFilter query, int? page);
  Future<HttpResponse<Pair<int, List<RealEstatePostModel>>>> getPostsStatus(
      String status, int? page);
  Future<HttpResponse<Pair<int, List<RealEstatePostModel>>>> getPostsExpired(
      int? page);
  Future<HttpResponse<void>> createPost(RealEstatePostModel post);
  Future<HttpResponse<List<String>>> uploadImages(List<File> images);
  Future<HttpResponse<List<String>>> getSuggestKeywords(String keyword);
}

class PostRemoteDataSrcImpl implements PostRemoteDataSrc {
  final Dio client;

  PostRemoteDataSrcImpl(this.client);

  @override
  Future<HttpResponse<Pair<int, List<RealEstatePostModel>>>> getAllPosts(
      String? userId, int? page) async {
    var url = '$apiAppUrl$kGetPostEndpoint';
    int pageQuery = page ?? 1;
    if (userId != null) {
      url += QueryBuilder()
          .addQuery('post_user_id', Operation.equals, '\'$userId\'')
          .addPage(pageQuery)
          .build();
    }
    print(success("url: $url"));
    return await DatabaseHelper().getPosts(url, client);
  }

  @override
  Future<HttpResponse<Pair<int, List<RealEstatePostModel>>>> getPostsStatus(
      String status, int? page) async {
    int pageQuery = page ?? 1;
    String url =
        '$apiAppUrl$kGetPostEndpoint${QueryBuilder().addQuery('post_status', Operation.equals, '\'$status\'').addPage(pageQuery).addOrderBy('posted_date', OrderBy.desc).build()}';

    return await DatabaseHelper().getPosts(url, client);
  }

  @override
  Future<HttpResponse<Pair<int, List<RealEstatePostModel>>>> getPostsExpired(
      int? page) async {
    int pageQuery = page ?? 1;
    String url = '$apiAppUrl$kGetPostEndpoint?page=$pageQuery';

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

      final int numOfPages = response.data["num_of_pages"];

      final List<DataMap> taskDataList =
          List<DataMap>.from(response.data["result"]);

      List<RealEstatePostModel> posts = taskDataList
          .map((postJson) => RealEstatePostModel.fromJson(postJson))
          //.where((post) => post.isActive!)
          //.where((post) => post.expiryDate!.isBefore(DateTime.now()))
          .toList();

      final value = Pair(numOfPages, posts);

      return HttpResponse(value, response);
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<void>> createPost(RealEstatePostModel postModel) async {
    const url = '$apiAppUrl$kCreatePostEndpoint';
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
    const url = '$apiAppUrl$kPostImages';

    List<FormData> formDataList = [];

    for (int i = 0; i < images.length; i++) {
      // Kiểm tra đuôi file
      String fileName = images[i].path.split('/').last;
      String fileExtension = extension(fileName).toLowerCase();
      String fileFormat = FileExt.getFileFormat(fileName);
      String fileType = FileExt.getFileType(fileName);

      // Chỉ thêm vào danh sách nếu là đuôi jpg
      if (fileExtension == '.jpg' || fileExtension == '.jpeg') {
        FormData formData = FormData.fromMap(
          {
            FileType.file: await MultipartFile.fromFile(
              images[i].path,
              filename: fileName,
              contentType: MediaType(fileType, fileFormat),
            ),
          },
        );
        formDataList.add(formData);
      } else {
        print(
            'File $fileName không phải là đuôi jpg, không được thêm vào danh sách.');
      }
    }

    try {
      Response response = await client.post(
        url,
        data: formDataList[0],
      );

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
  Future<HttpResponse<Pair<int, List<RealEstatePostModel>>>> getPostsSearch(
      PostFilter query, int? page) async {
    String url = '$apiAppUrl$kGetPostEndpoint';
    int pageQuery = page ?? 1;
    QueryBuilder queryBuilder = QueryBuilder();

    queryBuilder.addPage(pageQuery);

    if (query.textSearch != null && query.textSearch!.isNotEmpty) {
      queryBuilder.addSearch(query.textSearch!);
    }

    if (query.isLease != null) {
      queryBuilder.addQuery('post_is_lease', Operation.equals, query.isLease!);
    }

    if (query.provinceCode != null) {
      queryBuilder.addProvince(query.provinceCode!);
    }

    // if (query.postedBy != null) {
    //   url += QueryBuilder()
    //       .addQuery('post_user_id', Operation.equals, query.postedBy!.userId)
    //       .build();
    // }

    if (query.minPrice != null && query.maxPrice != null) {
      queryBuilder.addQuery('post_price', Operation.between,
          '${query.minPrice},${query.maxPrice}');
    }

    // area
    if (query.minArea != null && query.maxArea != null) {
      queryBuilder.addQuery(
          'post_area', Operation.between, '${query.minArea},${query.maxArea}');
    }

    // filter by post type
    if (query is ApartmentFilter) {
      queryBuilder.addQuery("post_type_id", Operation.equals, '\'apartment\'');
    }

    if (query is HouseFilter) {
      queryBuilder.addQuery("post_type_id", Operation.equals, '\'house\'');
    }

    if (query is LandFilter) {
      queryBuilder.addQuery("post_type_id", Operation.equals, '\'land\'');
    }

    if (query is OfficeFilter) {
      queryBuilder.addQuery("post_type_id", Operation.equals, '\'office\'');
    }

    if (query is MotelFilter) {
      queryBuilder.addQuery("post_type_id", Operation.equals, '\'motel\'');
    }

    url += queryBuilder.build();

    print(error(query.toString()));

    print(success("url: $url"));

    return await DatabaseHelper().getPosts(url, client);
  }

  @override
  Future<HttpResponse<List<String>>> getSuggestKeywords(String keyword) {
    String url = kGetSuggestKeywordsEndpoint.replaceAll('KEY_WORD', keyword);

    return client.get(url).then((response) {
      if (response.statusCode != 200) {
        throw ApiException(
          message: response.data,
          statusCode: response.statusCode!,
        );
      }

      final List<Map<String, dynamic>> taskDataList =
          List<Map<String, dynamic>>.from(response.data["results"] ?? []);
      List<String> values = [];
      for (var item in taskDataList) {
        if (item['formal'] != null) {
          values.add(item['formal'] as String);
        }
      }
      return HttpResponse(values, response);
    });
  }
}
