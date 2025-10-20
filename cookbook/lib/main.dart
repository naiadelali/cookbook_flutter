import 'dart:async';

import 'package:auth/auth.dart';
import 'package:cookbook/app_cubit_impl.dart';
import 'package:cookbook/navigation/app_navigation_impl.dart';
import 'package:core_common/navigation/app_navigation.dart';
import 'package:core_common/ui/state/cubit/app_cubit.dart';
import 'package:core_data/data_module.dart';
import 'package:core_database/database_module.dart';
import 'package:core_network/network_module.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

import 'app_widget.dart';
import 'firebase_options.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(Container(color: Colors.red));

    await Future.wait([
      // _initializeFirebase(), // Firebase commented out - configure with real credentials to enable
      _initializeInjections(),
    ]);

    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(
              create: (_) =>
                  AppCubitImpl(GetIt.I.get(), GetIt.I.get(), GetIt.I.get())),
          ...authCubits,
          ...homeCubits,
        ],
        child: AppWidget(),
      ),
    );
  }, (error, stack) {
    // Firebase Crashlytics disabled - uncomment when Firebase is properly configured
    // FirebaseCrashlytics.instance.recordError(error, stack);
    debugPrint('Error: $error\nStack: $stack');
  });
}

Future<void> _initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
}

Future<void> _initializeInjections() async {
  GetIt.I.registerSingleton<AppNavigation>(AppNavigationImpl());
  await coreDatabaseInjection();
  coreNetworkInjection();
  coreDataInjection();
  authInjection();
  homeInjection();
}
