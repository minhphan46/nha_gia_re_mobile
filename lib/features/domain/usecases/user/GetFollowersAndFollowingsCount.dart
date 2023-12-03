import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repository/user_repository.dart';

class GetFollowersAndFollowingsCount extends UseCase<Pair<int, int>, String> {
  final UserRepository repository;

  GetFollowersAndFollowingsCount(this.repository);

  @override
  Future<Pair<int, int>> call({String params = ''}) async {
    assert(params.trim().isNotEmpty);
    final result = await repository.getFollowersAndFollowingsCount(params);
    if (result is DataSuccess) {
      return result.data!;
    } else {
      throw Exception(
        'An error occurred while getting followers and followings count',
      );
    }
  }
}
