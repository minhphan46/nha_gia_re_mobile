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
import '../../models/post/limit_post.dart';
import '../../models/post/real_estate_post.dart';
import '../db/database_helper.dart';
import '../local/authentication_local_data_source.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

abstract class PostRemoteDataSrc {
  Future<HttpResponse<Pair<int, List<RealEstatePostModel>>>> getAllPosts(
      String? userId, int? page);
  Future<HttpResponse<Pair<int, List<RealEstatePostModel>>>> getPostsSearch(
      PostFilter query, int? page);
  Future<HttpResponse<Pair<int, List<RealEstatePostModel>>>> getPostsStatus(
      String status, int? page);
  Future<HttpResponse<Pair<int, List<RealEstatePostModel>>>> getPostsHided(
      int? page);
  Future<HttpResponse<Pair<int, List<RealEstatePostModel>>>> getPostsExpired(
      int? page);
  Future<HttpResponse<void>> createPost(RealEstatePostModel post);
  Future<HttpResponse<List<String>>> uploadImages(List<File> images);
  Future<HttpResponse<List<String>>> getSuggestKeywords(String keyword);
  Future<HttpResponse<void>> deletePost(String postId);
  Future<HttpResponse<void>> updatePost(RealEstatePostModel post);

  // get limit post
  Future<HttpResponse<LitmitPostModel>> getLimitPosts();

  Future<HttpResponse<Pair<int, List<RealEstatePostModel>>>> getPostsFavorite(
      int? page);

  // like post
  Future<HttpResponse<bool>> likePost(String postId);
}

class PostRemoteDataSrcImpl implements PostRemoteDataSrc {
  final Dio client;

  PostRemoteDataSrcImpl(this.client);

  @override
  Future<HttpResponse<Pair<int, List<RealEstatePostModel>>>> getAllPosts(
      String? userId, int? page) async {
    var url = '$apiAppUrl$kGetPostEndpoint';

    QueryBuilder queryBuilder = QueryBuilder();
    int pageQuery = page ?? 1;
    queryBuilder.addPage(pageQuery);

    if (userId != null) {
      queryBuilder.addQuery('post_user_id', Operation.equals, '\'$userId\'');
    }
    // post_is_active[eq]=true
    queryBuilder.addQuery('post_is_active', Operation.equals, 'true');

    queryBuilder.addQuery('post_status', Operation.equals, '\'approved\'');

    queryBuilder.addOrderBy('display_priority_point', OrderBy.desc);

    url += queryBuilder.build();
    return await DatabaseHelper().getPosts(url, client);
  }

  @override
  Future<HttpResponse<Pair<int, List<RealEstatePostModel>>>> getPostsStatus(
      String status, int? page) async {
    int pageQuery = page ?? 1;
    QueryBuilder queryBuilder = QueryBuilder();
    queryBuilder.addPage(pageQuery);
    queryBuilder.addQuery('post_status', Operation.equals, '\'$status\'');
    queryBuilder.addQuery('post_is_active', Operation.equals, 'true');
    queryBuilder.addOrderBy('posted_date', OrderBy.desc);

    String url = '$apiAppUrl$kGetPostEndpoint${queryBuilder.build()}';

    return await DatabaseHelper().getPosts(url, client);
  }

  @override
  Future<HttpResponse<Pair<int, List<RealEstatePostModel>>>> getPostsHided(
      int? page) async {
    int pageQuery = page ?? 1;

    QueryBuilder queryBuilder = QueryBuilder();
    queryBuilder.addPage(pageQuery);
    queryBuilder.addQuery('post_is_active', Operation.equals, 'false');
    queryBuilder.addOrderBy('posted_date', OrderBy.desc);

    String url = '$apiAppUrl$kGetPostEndpoint${queryBuilder.build()}';

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
      //print(postModel.toJson());

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
  Future<HttpResponse<void>> updatePost(RealEstatePostModel postModel) async {
    String url = '$apiAppUrl$kGetPostEndpoint/${postModel.id}';
    print(error('url: $url'));
    print(error('postModel: ${postModel.toJson()}'));

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

      final response = await client.patch(
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
  Future<HttpResponse<void>> deletePost(String postId) async {
    String url = '$apiAppUrl$kGetPostEndpoint' '/$postId';
    try {
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw const ApiException(
            message: 'Access token is null', statusCode: 505);
      }

      final response = await client.delete(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
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
      List<String> imageUrls = [];
      Response response = Response<dynamic>(
        data: {},
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      );
      for (int i = 0; i < formDataList.length; i++) {
        response = await client.post(
          url,
          data: formDataList[i],
        );

        if (response.statusCode == 200) {
          List<String> results = List<String>.from(response.data['result']);
          imageUrls.addAll(results);
        }
      }

      return HttpResponse<List<String>>(
        imageUrls,
        response,
      );
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

    if (query.orderBy != null) {
      if (query.orderBy!.isAsc == true) {
        queryBuilder.addOrderBy(query.orderBy!.filterString, OrderBy.asc);
      } else {
        queryBuilder.addOrderBy(query.orderBy!.filterString, OrderBy.desc);
      }
    } else {
      queryBuilder.addOrderBy('display_priority_point', OrderBy.desc);
    }

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
      queryBuilder.addText(query.toParam());
    }

    if (query is HouseFilter) {
      queryBuilder.addQuery("post_type_id", Operation.equals, '\'house\'');
      queryBuilder.addText(query.toParam());
    }

    if (query is LandFilter) {
      queryBuilder.addQuery("post_type_id", Operation.equals, '\'land\'');
      queryBuilder.addText(query.toParam());
    }

    if (query is OfficeFilter) {
      queryBuilder.addQuery("post_type_id", Operation.equals, '\'office\'');
      queryBuilder.addText(query.toParam());
    }

    if (query is MotelFilter) {
      queryBuilder.addQuery("post_type_id", Operation.equals, '\'motel\'');
      queryBuilder.addText(query.toParam());
    }

    queryBuilder.addQuery('post_status', Operation.equals, '\'approved\'');

    url += queryBuilder.build();

    //print(error(query.toString()));

    //print(success("url: $url"));

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

  @override
  Future<HttpResponse<LitmitPostModel>> getLimitPosts() async {
    const url = '$apiAppUrl$kGetLimitPostEndpoint';

    print(success('url: $url'));

    try {
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();

      return client
          .get(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
      )
          .then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }

        final LitmitPostModel data =
            LitmitPostModel.fromJson(response.data["result"]);

        return HttpResponse(data, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  @override
  Future<HttpResponse<Pair<int, List<RealEstatePostModel>>>> getPostsFavorite(
      int? page) async {
    const url = '$apiAppUrl$kGetPostFavoriteEndpoint';
    try {
      final response = await client.get(url,
          options: Options(headers: {
            'Authorization':
                'Bearer ${sl<AuthenLocalDataSrc>().getAccessToken()}',
          }));
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
  Future<HttpResponse<bool>> likePost(String postId) {
    String url = '$apiAppUrl$kMarkFavEndpoint/$postId';

    try {
      // get access token
      AuthenLocalDataSrc localDataSrc = sl<AuthenLocalDataSrc>();
      String? accessToken = localDataSrc.getAccessToken();
      if (accessToken == null) {
        throw const ApiException(
            message: 'Access token is null', statusCode: 505);
      }

      final response = client.post(
        url,
        options: Options(
            sendTimeout: const Duration(seconds: 10),
            headers: {'Authorization': 'Bearer $accessToken'}),
      );

      return response.then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data['message'],
            statusCode: response.statusCode!,
          );
        }

        // Nếu yêu cầu thành công, giải mã dữ liệu JSON
        bool isLikePost =
            response.data['message'].toString().contains("Favorite");

        return HttpResponse(isLikePost, response);
      });
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
