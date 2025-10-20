import 'package:core_common/navigation/navigation_service.dart';
import 'package:home/home.dart';
import 'package:home/src/l10n/gen/app_localizations_pt.dart';

class ModuleStrings {
  ModuleStrings._();

  static HomeLocalizations get _localizations =>
      NavigationService.navigatorKey.currentContext != null ? HomeLocalizations
      .of(NavigationService.navigatorKey.currentContext!) : HomeLocalizationsPt();

  static get explorePage => _localizations.explorePage;
  static get homePage => _localizations.homePage;
  static get token => _localizations.token;
  static get refreshToken => _localizations.refreshToken;
  static get logout => _localizations.logout;
  static get notLogged => _localizations.notLogged;
  static get profilePage => _localizations.profilePage;
  static get settingsPage => _localizations.settingsPage;
  static get explore => _localizations.explore;
  static get home => _localizations.home;
  static get profile => _localizations.profile;
  static get settings => _localizations.settings;
}