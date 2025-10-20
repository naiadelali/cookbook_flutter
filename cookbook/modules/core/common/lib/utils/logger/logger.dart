abstract class Logger {
  void log(Object object);

  void handleException(
    dynamic exception,
    StackTrace? stack, {
    bool fatal = false,
  });
}
