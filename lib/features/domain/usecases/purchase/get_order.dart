import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/entities/purchase/order_membership_package.dart';
import 'package:nhagiare_mobile/features/domain/repository/membership_package_repository.dart';

class GetOrderMembershipPackageUseCase
    implements
        UseCase<DataState<OrderMembershipPackage>, Map<String, dynamic>> {
  final MembershipPackageRepository _membershipPackageRepository;

  GetOrderMembershipPackageUseCase(this._membershipPackageRepository);

  @override
  Future<DataState<OrderMembershipPackage>> call(
      {Map<String, dynamic>? params}) {
    return _membershipPackageRepository.createOrder(
        params!['package_id'], params['num_of_month']);
  }
}
