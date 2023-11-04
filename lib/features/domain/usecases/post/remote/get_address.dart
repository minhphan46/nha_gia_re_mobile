import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/data/models/post/address.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/address.dart';
import 'package:nhagiare_mobile/features/domain/repository/provinces_repository.dart';

class GetAddressUseCase
    implements UseCaseSync<DataState<String>, AddressModel> {
  final ProvincesRepository _provincesRepository;

  GetAddressUseCase(this._provincesRepository);

  @override
  DataState<String> call({AddressEntity? params}) {
    return _provincesRepository.getFullAddress(
      params!.detail,
      params.provinceCode!,
      params.districtCode!,
      params.wardCode!,
    );
  }
}
