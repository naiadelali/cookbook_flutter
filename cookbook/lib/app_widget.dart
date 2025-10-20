import 'package:cookbook/l10n/app_l10n.dart';
import 'package:cookbook/navigation/app_routes.dart';
import 'package:core_common/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      scaffoldMessengerKey: NavigationService.scaffoldMessengerKey,
      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.darkTheme,
      localizationsDelegates: const [
        ...AppL10n.localizationsDelegates,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppL10n.supportedLocales,
    );
  }
}
