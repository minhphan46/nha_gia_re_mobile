import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repository/user_repository.dart';

class FollowOrUnfollowUserUseCase extends UseCase<bool, String> {
  final UserRepository _userRepository;

  FollowOrUnfollowUserUseCase(this._userRepository);

  @override
  Future<bool> call({String params = ''}) async {
    assert(params.trim().isNotEmpty);

    final result = await _userRepository.followOrUnfollowUser(params);
    if (result is DataSuccess) {
      return result.data!;
    } else {
      throw Exception('An error occurred while following/unfollowing user');
    }
  }
}
