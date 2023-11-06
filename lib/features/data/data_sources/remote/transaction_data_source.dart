import 'package:dio/dio.dart';
import 'package:nhagiare_mobile/features/data/models/membership_package_model.dart';
import 'package:nhagiare_mobile/features/data/models/transaction_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:nhagiare_mobile/core/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/typedef.dart';

abstract class TransactionRemoteDataSrc {
  // Future<HttpResponse<List<TransactionModel>>> getAllMembershipPackages();
  Future<HttpResponse<TransactionModel>> getTransactionByAppTransId(String id);
}

class TransactionRemoteDataSrcImpl extends TransactionRemoteDataSrc {
  final Dio client;

  TransactionRemoteDataSrcImpl(this.client);

  @override
  Future<HttpResponse<TransactionModel>> getTransactionByAppTransId(String id) {
    String url = '$apiBaseUrl$kGetTransactionEndpoint?id=$id';
    try {
      return client.get(url).then((response) {
        if (response.statusCode != 200) {
          throw ApiException(
            message: response.data,
            statusCode: response.statusCode!,
          );
        }

        final DataMap taskDataList = DataMap.from(response.data["result"]);

        TransactionModel value = TransactionModel.fromJson(taskDataList);

        return HttpResponse(value, response);
      });
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(message: error.toString(), statusCode: 505);
    }
  }
}
