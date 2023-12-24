import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/provinces_repository.dart';

class GetDistrictNamesUseCase
    implements UseCaseSync<DataState<List<Map<String, dynamic>>>, int> {
  final ProvincesRepository _provincesRepository;

  GetDistrictNamesUseCase(this._provincesRepository);

  @override
  DataState<List<Map<String, dynamic>>> call({int? params}) {
    return _provincesRepository.getDistrictMap(params!);
  }
}
