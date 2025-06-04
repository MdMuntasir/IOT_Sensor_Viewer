import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot/features/show%20data/data/model/alert_condtion_model.dart';
import 'package:iot/features/show%20data/domain/entity/show_data_entity.dart';
import 'package:iot/features/show%20data/presentation/state/show_data_bloc.dart';
import 'package:iot/features/show%20data/presentation/state/show_data_event.dart';
import 'package:iot/features/show%20data/presentation/state/show_data_state.dart';
import 'package:iot/features/show%20data/presentation/widgets/analog_data_shower.dart';
import 'package:iot/features/show%20data/presentation/widgets/digital_data_shower.dart';
import 'package:iot/features/show%20data/presentation/widgets/subscribe_topic.dart';
import 'package:iot/injection_dependecies.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/services/notification_service.dart';

class DataShowPage extends StatefulWidget {
  const DataShowPage({super.key});

  @override
  State<DataShowPage> createState() => _DataShowPageState();
}

class _DataShowPageState extends State<DataShowPage> {
  List<ShowDataEntity> data = [];
  List<Widget> sensors = [];
  String topic = "";
  final TextEditingController topicController = TextEditingController();

  void setMqtt() {
    context.read<ShowDataBloc>().add(SubscribeTopicEvent(topic, (models) {
          String alertMessage = "";
          sensors.clear();
          for (ShowDataEntity model in models) {
            model.isDigital!
                ? sensors.add(DigitalDataShower(
                    value: (model.value != 0.0),
                    label: model.name ?? "",
                    iconData: Icons.circle,
                  ))
                : sensors.add(AnalogDataShower(
                    value: model.value ?? 0.0, sensor: model.name ?? ""));
            if (AlertConditionModel(model.alertValue ?? 1.0,
                    model.alertCondition ?? "G", model.value ?? 1.0)
                .evaluateCondition()) {
              alertMessage += "${model.name} alert: ${model.value}\n";
            }
          }

          if (alertMessage.isNotEmpty) {
            serviceLocator<NotificationService>().showNotification(
              title: "⚠️ IoT Device Alert",
              body: alertMessage.trim(),
            );
          }

          setState(() {
            data = models;
          });
        }));
  }

  Future<void> requestNotificationPermissions() async {
    try {
      if (Platform.isAndroid) {
        final notificationStatus = await Permission.notification.status;

        if (notificationStatus.isDenied) {
          final result = await Permission.notification.request();

          if (result.isDenied) {
            _showPermissionDialog();
          } else if (result.isPermanentlyDenied) {
            _showSettingsDialog();
          }
        } else if (notificationStatus.isPermanentlyDenied) {
          _showSettingsDialog();
        }

        if (Platform.isAndroid) {
          final postNotificationStatus =
              await Permission.scheduleExactAlarm.status;
          if (postNotificationStatus.isDenied) {
            await Permission.scheduleExactAlarm.request();
          }
        }
      }
    } catch (e) {
      debugPrint('Error requesting notification permissions: $e');
    }
  }

  void _showPermissionDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notification Permission'),
          content: const Text(
            'Notifications are required to alert you about sensor readings. '
            'Please enable it in app settings to receive alerts.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Settings'),
            ),
          ],
        );
      },
    );
  }

  void _showSettingsDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
            'Notification permission has been permanently denied. '
            'Please enable it in app settings to receive alerts.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Settings'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    requestNotificationPermissions();
  }

  @override
  void dispose() {
    topicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Show Sensor Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocConsumer(
        bloc: context.read<ShowDataBloc>(),
        listener: (context, state) {
          SubscribeTopic(
            controller: topicController,
            function: setMqtt,
          );
        },
        builder: (context, state) {
          if (state is LoadingShowDataState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DataFailedState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      setMqtt();
                    });
                  },
                  icon: const Icon(Icons.refresh, size: 40),
                ),
                SizedBox(height: h * .02),
                Text(state.errorMessage),
              ],
            );
          } else if (state is DataLoadedShowDataState) {
            return Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: w * .03,
              runSpacing: h * .02,
              children: sensors,
            );
          }

          return Scaffold(
            body: Center(
              child: SubscribeTopic(
                controller: topicController,
                function: () {
                  topic = topicController.text;
                  setMqtt();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
