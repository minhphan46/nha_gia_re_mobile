import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/features/domain/entities/user/user.dart';

import '../../../../core/usecases/usecase.dart';
import '../../repository/authentication_repository.dart';

class GetMeUseCase extends UseCase<UserEntity, void> {
  final AuthenticationRepository repository;

  GetMeUseCase({required this.repository});

  @override
  Future<UserEntity> call({void params}) async {
    final result = await repository.getMe();
    if (result is DataSuccess) {
      return result.data!;
    } else {
      throw result.error!;
    }
  }
}
