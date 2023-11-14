import 'package:nhagiare_mobile/features/data/models/order_membership_package_model.dart';
import 'package:nhagiare_mobile/features/domain/entities/membership_package.dart';

import '../../../../core/resources/data_state.dart';

abstract class MembershipPackageRepository {
  Future<DataState<List<MembershipPackageEntity>>> getMembershipPackages();
  Future<DataState<OrderMembershipPackageModel>> createOrder(
      String packageId, int numOfMonth);
}
