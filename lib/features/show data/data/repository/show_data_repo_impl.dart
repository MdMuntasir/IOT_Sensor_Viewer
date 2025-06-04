import 'package:iot/core/network/data_state.dart';
import 'package:iot/core/services/mqtt_service.dart';
import 'package:iot/features/show%20data/domain/entity/show_data_entity.dart';
import 'package:iot/features/show%20data/domain/repository/show_data_repo.dart';
import '../../../../core/network/connection_checker.dart';
import '../data source/remote_source.dart';

class ShowDataRepoImplementation implements ShowDataRepository {
  final ConnectionChecker connectionChecker;
  final RemoteDeviceData remoteDeviceData;
  final MQTTClient mqttClient;

  const ShowDataRepoImplementation(
    this.remoteDeviceData,
    this.connectionChecker,
    this.mqttClient,
  );

  @override
  Future<DataState> connectClient() async {
    if (await connectionChecker.isConnected) {
      try {
        final client = await mqttClient.connectClient();
        if (client != null) {
          return DataSuccess(client);
        } else {
          return DataFailed("Can't connect to client");
        }
      } on Exception catch (e) {
        return DataFailed(e.toString());
      }
    } else {
      return DataFailed("No internet connection");
    }
  }

  @override
  Future<DataState<String>> subscribe(
    String topic,
    Function(List<ShowDataEntity>)? onMessageReceived,
  ) async {
    final data = remoteDeviceData.mqttSubscribeData(
      topic,
      onMessageReceived,
    );
    if (data is DataSuccess) {
      return DataSuccess(data.data!);
    } else {
      return DataFailed(data.error!);
    }
  }
}
