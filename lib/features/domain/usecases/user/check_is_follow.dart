import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repository/user_repository.dart';

class CheckIsFollowUser extends UseCase<bool, String> {
  final UserRepository _userRepository;

  CheckIsFollowUser(this._userRepository);

  @override
  Future<bool> call({String params = ''}) async {
    final result = await _userRepository.checkFollowUser(params);
    if (result is DataSuccess) {
      return result.data!;
    } else {
      throw Exception('An error occurred while following/unfollowing user');
    }
  }
}
