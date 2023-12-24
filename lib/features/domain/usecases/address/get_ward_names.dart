import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/resources/pair.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/provinces_repository.dart';

class GetWardNamesUseCase
    implements
        UseCaseSync<DataState<List<Map<String, dynamic>>>, Pair<int, int>> {
  final ProvincesRepository _provincesRepository;

  GetWardNamesUseCase(this._provincesRepository);

  @override
  DataState<List<Map<String, dynamic>>> call({Pair<int, int>? params}) {
    return _provincesRepository.getWardMap(params!.first, params.second);
  }
}
