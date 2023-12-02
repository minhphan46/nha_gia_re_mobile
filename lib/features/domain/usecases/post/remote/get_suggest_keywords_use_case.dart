import 'package:nhagiare_mobile/core/usecases/usecase.dart';

import '../../../repository/post_repository.dart';

class GetSuggestKeywordsUseCase extends UseCase<List<String>, String> {
  final PostRepository repository;

  GetSuggestKeywordsUseCase(this.repository);

  @override
  Future<List<String>> call({String params = ""}) async {
    final result = await repository.getSuggestKeywords(params);
    return result.data ?? [];
  }
}
