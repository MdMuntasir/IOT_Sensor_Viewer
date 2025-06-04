import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot/config/themes/theme_data.dart';
import 'package:iot/features/show%20data/presentation/state/show_data_bloc.dart';
import 'package:iot/injection_dependecies.dart';
import 'package:iot/features/show%20data/presentation/pages/data_show_page.dart';

import 'core/services/notification_service.dart';

void main() async {
  await initializeDependency();
  await serviceLocator<NotificationService>().initNotification();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<ShowDataBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: const DataShowPage(),
    );
  }
}
