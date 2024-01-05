import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/features/domain/repository/membership_package_repository.dart';

import '../../../../core/usecases/usecase.dart';

class UnsubscribeUseCase extends UseCase<bool, void> {
  final MembershipPackageRepository repository;

  UnsubscribeUseCase(this.repository);

  @override
  Future<bool> call({void params}) async {
    final res = await repository.unsubscribe();
    return res is DataSuccess ? res.data ?? false : false;
  }
}
