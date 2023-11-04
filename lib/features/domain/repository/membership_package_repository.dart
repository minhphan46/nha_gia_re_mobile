import 'package:nhagiare_mobile/features/domain/entities/membership_package.dart';

import '../../../../core/resources/data_state.dart';

abstract class MembershipPackageRepository {
  Future<DataState<List<MembershipPackageEntity>>> getMembershipPackages();
}
