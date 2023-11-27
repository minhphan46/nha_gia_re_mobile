import 'dart:io';
import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/post_repository.dart';

class UploadImagessUseCase
    implements UseCase<DataState<List<String>>, List<File>> {
  final PostRepository _postRepository;

  UploadImagessUseCase(this._postRepository);

  @override
  Future<DataState<List<String>>> call({List<File>? params}) {
    return _postRepository.uploadImages(params!);
  }
}
