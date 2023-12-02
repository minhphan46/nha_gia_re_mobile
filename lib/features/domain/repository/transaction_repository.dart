import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/features/data/models/purchase/subscription_model.dart';
import 'package:nhagiare_mobile/features/domain/entities/purchase/transaction.dart';

abstract class TransactionRepository {
  // Future<DataState<List<TransactionEntity>>> getTransactions();

  Future<DataState<TransactionEntity>> getTransactionByAppTransId(String id);
  Future<DataState<List<TransactionEntity>>> getAllTransactions();
  Future<DataState<SubscriptionModel?>> getCurrentSubscription();
}
