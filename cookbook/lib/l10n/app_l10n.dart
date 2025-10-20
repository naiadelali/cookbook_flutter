import 'package:auth/auth.dart';
import 'package:cookbook/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';

class AppL10n {
  AppL10n._();

  static const ptBR = Locale('pt', 'BR');

  static const List<Locale> supportedLocales = [ptBR];

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    ...AppLocalizations.localizationsDelegates,
    ...AuthLocalizations.localizationsDelegates,
    ...HomeLocalizations.localizationsDelegates,
  ];
}