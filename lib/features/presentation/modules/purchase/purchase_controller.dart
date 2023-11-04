import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/features/domain/entities/membership_package.dart';
import 'package:nhagiare_mobile/features/domain/usecases/purchase/get_membership_package.dart';
import 'package:nhagiare_mobile/injection_container.dart';

class PurchaseController extends GetxController {
  final getMembershipPackageUseCase = sl<GetMembershipPackageUseCase>();

  Future<List<MembershipPackageEntity>> getMembershipPackages() async {
    final result = await getMembershipPackageUseCase();
    if (result is DataSuccess) {
      return result.data!;
    } else {
      return [];
    }
  }
}
