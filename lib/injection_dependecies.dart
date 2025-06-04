import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:iot/core/network/connection_checker.dart';
import 'package:iot/core/services/mqtt_service.dart';
import 'package:iot/core/services/notification_service.dart';
import 'package:iot/features/show%20data/data/data%20source/remote_source.dart';
import 'package:iot/features/show%20data/data/repository/show_data_repo_impl.dart';
import 'package:iot/features/show%20data/domain/repository/show_data_repo.dart';
import 'package:iot/features/show%20data/domain/usecase/connect_client_usecase.dart';
import 'package:iot/features/show%20data/domain/usecase/subscribe_client_usecase.dart';
import 'package:iot/features/show%20data/presentation/state/show_data_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependency() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  _showDataInit();

  serviceLocator.registerLazySingleton<NotificationService>(()=>NotificationService());
  serviceLocator.registerLazySingleton<MQTTClient>(() => MQTTClient());
  serviceLocator.registerLazySingleton<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      InternetConnection.createInstance(),
    ),
  );


}


void _showDataInit(){
  serviceLocator
    ..registerFactory<RemoteDeviceData>(
          () => RemoteDeviceDataImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<ShowDataRepository>(() => ShowDataRepoImplementation(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ))
    ..registerFactory<SubscribeClientUseCase>(
          () => SubscribeClientUseCase(
        serviceLocator(),
      ),
    )
    ..registerFactory<ConnectClientUseCase>(
          () => ConnectClientUseCase(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(() => ShowDataBloc(
      connectClientUseCase: serviceLocator(),
      subscribeClientUseCase: serviceLocator(),
    ));
}