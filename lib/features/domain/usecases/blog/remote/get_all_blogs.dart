import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/entities/blog.dart';
import 'package:nhagiare_mobile/features/domain/repository/blog_repository.dart';

class GetBlogsUseCase implements UseCase<DataState<List<BlogEntity>>, void> {
  final BlogRepository _blogRepository;

  GetBlogsUseCase(this._blogRepository);

  @override
  Future<DataState<List<BlogEntity>>> call({void params}) {
    return _blogRepository.getAllBlogs();
  }
}
