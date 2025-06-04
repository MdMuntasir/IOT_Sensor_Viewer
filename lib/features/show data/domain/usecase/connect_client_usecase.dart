import 'package:iot/core/network/data_state.dart';
import 'package:iot/core/usecase/usecase.dart';
import 'package:iot/features/show%20data/domain/repository/show_data_repo.dart';

class ConnectClientUseCase implements UseCase<dynamic, void> {
  final ShowDataRepository showDataRepository;
  const ConnectClientUseCase(this.showDataRepository);

  @override
  Future<DataState> call({para}) async {
    return await showDataRepository.connectClient();
  }
}

