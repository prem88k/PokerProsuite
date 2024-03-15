
import "package:flutter/foundation.dart";

import "../Model/anonymous_user.dart";
import "../Screens/services/error_reporter_service.dart";

class NoopErrorReporterService implements ErrorReporterService {
  NoopErrorReporterService();

  void setUser(AnonymousUser? user) {}

  Future<void> captureException({
    required dynamic exception,
    required StackTrace stackTrace,
  }) async {}

  Future<void> captureFlutterException(FlutterErrorDetails details) async {}
}
