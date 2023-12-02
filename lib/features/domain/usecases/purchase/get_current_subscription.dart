import 'dart:ffi';

import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/usecases/usecase.dart';
import '../../entities/purchase/subscription.dart';
import '../../repository/transaction_repository.dart';

class GetCurrentSubscriptionUseCase extends UseCase<Subscription?, void> {
  final TransactionRepository repository;

  GetCurrentSubscriptionUseCase(this.repository);

  @override
  Future<Subscription?> call({void params}) async {
    final subscription = await repository.getCurrentSubscription();
    if (subscription is DataSuccess) {
      return subscription.data;
    } else {
      return null;
    }
  }
}
