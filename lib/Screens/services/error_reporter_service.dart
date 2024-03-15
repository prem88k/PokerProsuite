import "package:flutter/foundation.dart";

import "../../Model/anonymous_user.dart";

abstract class ErrorReporterService {
  void setUser(AnonymousUser? user);

  Future<void> captureException({
    required dynamic exception,
    required StackTrace stackTrace,
  });

  Future<void> captureFlutterException(FlutterErrorDetails details);
}
