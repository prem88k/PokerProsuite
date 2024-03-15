
import "package:flutter/foundation.dart";

import "../../Model/anonymous_user.dart";

abstract class AuthManagerService extends ChangeNotifier {
  AnonymousUser? get user;

  Future<void> initialize();
}
