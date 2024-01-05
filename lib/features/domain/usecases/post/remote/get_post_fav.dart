import 'package:nhagiare_mobile/core/resources/pair.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../entities/posts/real_estate_post.dart';
import '../../../repository/post_repository.dart';

class GetPostFavorite
    extends UseCase<Pair<int, List<RealEstatePostEntity>>, int> {
  final PostRepository repository;

  GetPostFavorite(this.repository);

  @override
  Future<Pair<int, List<RealEstatePostEntity>>> call({int? params}) async {
    final page = params;
    final result = await repository.getPostsFavorite(page);
    if (result is DataSuccess) {
      return Pair(result.data!.first, result.data!.second);
    } else {
      return Pair(0, []);
    }
  }
}
