import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/repository/provinces_repository.dart';

class GetProvinceNamesUseCase
    implements UseCaseSync<DataState<List<String>>, void> {
  final ProvincesRepository _provincesRepository;

  GetProvinceNamesUseCase(this._provincesRepository);

  @override
  DataState<List<String>> call({void params}) {
    return _provincesRepository.getProvinceNames();
  }
}
