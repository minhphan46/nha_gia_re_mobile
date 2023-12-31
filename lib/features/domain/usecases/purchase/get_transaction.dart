import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/entities/purchase/transaction.dart';
import 'package:nhagiare_mobile/features/domain/repository/transaction_repository.dart';

class GetTransactionUseCase
    implements UseCase<DataState<TransactionEntity>, String> {
  final TransactionRepository _transtractionRepository;

  GetTransactionUseCase(this._transtractionRepository);

  @override
  Future<DataState<TransactionEntity>> call({String? params}) {
    return _transtractionRepository.getTransactionByAppTransId(params!);
  }
}
