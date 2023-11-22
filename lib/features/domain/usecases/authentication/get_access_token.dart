import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/authentication_repository.dart';

class GetAccessTokenUseCase implements UseCase<String, void> {
  final AuthenticationRepository repository;

  GetAccessTokenUseCase(this.repository);

  @override
  Future<String> call({void params}) async {
    final accessToken = await repository.getAccessToken();
    return accessToken.data!;
  }
}
