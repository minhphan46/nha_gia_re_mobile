import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/entities/membership_package.dart';
import 'package:nhagiare_mobile/features/domain/repository/membership_package_repository.dart';

class GetMembershipPackageUseCase
    implements UseCase<DataState<List<MembershipPackageEntity>>, void> {
  final MembershipPackageRepository _membershipPackageRepository;

  GetMembershipPackageUseCase(this._membershipPackageRepository);

  @override
  Future<DataState<List<MembershipPackageEntity>>> call({void params}) {
    return _membershipPackageRepository.getMembershipPackages();
  }
}
