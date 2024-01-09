import 'package:nhagiare_mobile/features/domain/enums/verification_status.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repository/user_repository.dart';

class GetVerificationUsecase
    extends UseCase<Pair<VerificationStatus, String>, void> {
  final UserRepository repository;

  GetVerificationUsecase(this.repository);

  @override
  Future<Pair<VerificationStatus, String>> call({void params}) async {
    final result = await repository.getVerificationStatus();
    if (result is DataSuccess) {
      return result.data!;
    } else {
      throw Exception(
        'An error occurred while getting verification status',
      );
    }
  }
}
