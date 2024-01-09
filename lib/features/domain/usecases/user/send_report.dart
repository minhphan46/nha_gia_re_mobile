import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/core/usecases/usecase.dart';
import 'package:nhagiare_mobile/features/domain/entities/user/report.dart';
import 'package:nhagiare_mobile/features/domain/repository/user_repository.dart';

class SendReportUsecase implements UseCase<DataState<void>, ReportEntity> {
  final UserRepository _postRepository;

  SendReportUsecase(this._postRepository);

  @override
  Future<DataState<void>> call({ReportEntity? params}) {
    return _postRepository.sendReport(params!);
  }
}
