import 'package:auth/auth.dart';
import 'package:auth/src/l10n/gen/app_localizations_pt.dart';
import 'package:core_common/navigation/navigation_service.dart';

class ModuleStrings {
  ModuleStrings._();

  static AuthLocalizations get _localizations =>
      NavigationService.navigatorKey.currentContext != null
          ? AuthLocalizations.of(NavigationService.navigatorKey.currentContext!)
          : AuthLocalizationsPt();

  static get reportPassword => _localizations.reportPassword;
  static get reportYourEmail => _localizations.reportYourEmail;
  static get insertPassword => _localizations.insertPassword;
  static get insertUser => _localizations.insertUser;
  static get flutterLoginTemplate => _localizations.flutterLoginTemplate;
  static get login => _localizations.login;
  static get examplesButton => _localizations.examplesButton;
}
