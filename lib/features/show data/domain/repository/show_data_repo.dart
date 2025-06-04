import 'package:iot/features/show%20data/domain/entity/show_data_entity.dart';

import '../../../../core/network/data_state.dart';

abstract class ShowDataRepository {
  Future<DataState<String>> subscribe(
    String topic,
    Function(List<ShowDataEntity>)? onMessageReceived,
  );

  Future<DataState> connectClient();
}
