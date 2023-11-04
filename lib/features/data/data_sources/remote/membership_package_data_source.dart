import 'package:dio/dio.dart';
import 'package:nhagiare_mobile/features/data/models/membership_package_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:nhagiare_mobile/core/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/typedef.dart';

abstract class MembershipPackageRemoteDataSrc {
  Future<HttpResponse<List<MembershipPackageModel>>> getAllMembershipPackages();
}

class MembershipPackageRemoteDataSrcImpl
    implements MembershipPackageRemoteDataSrc {
  final Dio client;

  MembershipPackageRemoteDataSrcImpl(this.client);

  @override
  Future<HttpResponse<List<MembershipPackageModel>>>
      getAllMembershipPackages() {
    const url = '$apiBaseUrl$kGetMembershipPackageEndpoint';

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

        List<MembershipPackageModel> value = taskDataList
            .map((postJson) => MembershipPackageModel.fromJson(postJson))
            .toList();

        return HttpResponse(value, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }

  // @override
  // Future<HttpResponse<List<RealEstatePostModel>>> getAllPosts() async {
  //   const url = '$apiBaseUrl$kGetPostEndpoint';

  //   try {
  //     final response = await client.get(url);
  //     //print('${response.statusCode} : ${response.data["message"].toString()}');
  //     if (response.statusCode != 200) {
  //       //print('${response.statusCode} : ${response.data["result"].toString()}');
  //       throw ApiException(
  //         message: response.data,
  //         statusCode: response.statusCode!,
  //       );
  //     }

  //     final List<DataMap> taskDataList =
  //         List<DataMap>.from(response.data["result"]);

  //     List<RealEstatePostModel> value = taskDataList
  //         .map((postJson) => RealEstatePostModel.fromJson(postJson))
  //         .toList();

  //     return HttpResponse(value, response);
  //   } on ApiException {
  //     rethrow;
  //   } catch (error) {
  //     throw ApiException(message: error.toString(), statusCode: 505);
  //   }
  // }
}
