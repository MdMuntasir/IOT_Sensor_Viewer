import 'dart:convert';
import 'package:iot/features/show%20data/data/model/show_data_model.dart';
import 'package:iot/features/show%20data/domain/entity/show_data_entity.dart';
import '../../../../core/network/data_state.dart';
import '../../../../core/services/mqtt_service.dart';

abstract class RemoteDeviceData {
  DataState<String> mqttSubscribeData(
    String topic,
    Function(List<ShowDataEntity>)? onMessageReceived,
  );
}

class RemoteDeviceDataImpl implements RemoteDeviceData {
  final MQTTClient mqttClient;
  const RemoteDeviceDataImpl(this.mqttClient);

  @override
  DataState<String> mqttSubscribeData(
    String topic,
    Function(List<ShowDataEntity>)? onMessageReceived,
  ) {
    try {
      mqttClient.subscribeTopic(topic, (message) {
        if (message.startsWith("{") && message.endsWith("}")) {
          Map<String, dynamic> jsonData = jsonDecode(message);
          if (jsonData.containsKey("sensors")) {
            List<ShowDataEntity> sensors = [];
            for (Map<String, dynamic> sensor in jsonData["sensors"]) {
              sensors.add(ShowDataModel.fromJson(sensor));
            }
            onMessageReceived!(sensors);
          }
        }
      });
      return DataSuccess("Successfully Subscribed Topic");
    } on Exception catch (e) {
      return DataFailed(e.toString());
    }
  }
}
