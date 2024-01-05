import 'package:nhagiare_mobile/core/resources/pair.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/purchase/discount_code.dart';
import '../../repository/membership_package_repository.dart';

class GetDiscountCodeUseCaseParams {
  final int page;
  final String packageId;

  GetDiscountCodeUseCaseParams(this.page, this.packageId);
}

class GetDiscountCodeUseCase extends UseCase<
    Pair<int, List<DiscountCodeEntity>>, GetDiscountCodeUseCaseParams> {
  final MembershipPackageRepository repository;

  GetDiscountCodeUseCase(this.repository);

  @override
  Future<Pair<int, List<DiscountCodeEntity>>> call(
      {GetDiscountCodeUseCaseParams? params}) async {
    final page = params!.page;
    final packageId = params.packageId;
    final result = await repository.getAllDiscountCodes(page, packageId);
    if (result is DataSuccess) {
      return Pair(result.data!.first, result.data!.second);
    } else {
      return Pair(0, []);
    }
  }
}
