import 'dart:io';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import '../network/connection_checker.dart';
import 'client_state.dart';

class MQTTClient {
  MqttServerClient? client;
  ConnectionChecker connectionChecker =
  ConnectionCheckerImpl(InternetConnection());

  Future<MqttServerClient?> connectClient() async {
      client = MqttServerClient.withPort("broker.emqx.io", "Android Device", 1883);
      client?.secure = false;
      client?.securityContext = SecurityContext.defaultContext;
      client?.keepAlivePeriod = 20;
      await client?.connect();
      return client;
  }

  void subscribeTopic(String topic, Function(String)? onMessageReceived,){
    client?.subscribe(topic, MqttQos.atMostOnce);

    client?.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;
      final message =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      if (onMessageReceived != null) {
        onMessageReceived(message);
      }
    });
  }

  ClientState getClient() {
    final mqttStatus = client?.connectionStatus;
    if (mqttStatus?.state == MqttConnectionState.connected) {
      return ClientConnected(client!);
    }
    return ClientDisconnected(mqttStatus?.disconnectionOrigin.toString());
  }
}