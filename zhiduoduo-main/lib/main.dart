import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:zhi_duo_duo/core/services/log_service.dart';
import 'package:zhi_duo_duo/firebase_options.dart';
import 'package:zhi_duo_duo/locator.dart';
import 'package:zhi_duo_duo/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GlobalConfiguration().loadFromAsset("app_settings");
  LogService.init();
  setupLocator();
  GetIt.instance.registerSingleton<AppRouter>(AppRouter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = GetIt.instance<AppRouter>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner:
          GlobalConfiguration().getValue("environment") == 'development',
    );
  }
}
