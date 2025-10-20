import 'package:core_common/utils/logger/logger.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class FirebaseCrashlyticsLoggerImpl extends Logger {
  @override
  void log(Object object) {
    FirebaseCrashlytics.instance.log(object.toString());
  }

  @override
  void handleException(
    dynamic exception,
    StackTrace? stack, {
    bool fatal = false,
  }) {
    FirebaseCrashlytics.instance.recordError(exception, stack, fatal: fatal);
  }
}
