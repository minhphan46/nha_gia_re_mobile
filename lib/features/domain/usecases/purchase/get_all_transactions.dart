import 'package:nhagiare_mobile/core/usecases/usecase.dart';

import '../../../../core/resources/data_state.dart';
import '../../entities/purchase/transaction.dart';
import '../../repository/transaction_repository.dart';

class GetAllTransactionUseCase
    extends UseCase<DataState<List<TransactionEntity>>, int> {
  final TransactionRepository repository;

  GetAllTransactionUseCase(this.repository);

  @override
  Future<DataState<List<TransactionEntity>>> call({int params = 0}) {
    return repository.getAllTransactions();
  }
}
