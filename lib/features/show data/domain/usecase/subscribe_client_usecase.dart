import 'package:iot/core/network/data_state.dart';
import 'package:iot/core/usecase/usecase.dart';
import 'package:iot/features/show%20data/domain/entity/show_data_entity.dart';

import '../repository/show_data_repo.dart';

class SubscribeClientUseCase implements UseCase<dynamic, SubscribeCred> {
  final ShowDataRepository showDataRepository;
  const SubscribeClientUseCase(this.showDataRepository);

  @override
  Future<DataState> call({SubscribeCred? para}) async {
    return await showDataRepository.subscribe(
      para!.topic,
      para.onMessageReceived,
    );
  }
}

class SubscribeCred {
  final String topic;
  final void Function(List<ShowDataEntity>) onMessageReceived;

  const SubscribeCred(
    this.topic,
    this.onMessageReceived,
  );
}
