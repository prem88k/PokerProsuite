import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/foundation.dart";

import "../Model/anonymous_user.dart";
import "../Screens/services/auth_manager_service.dart";

class FirebaseAuthManagerService extends ChangeNotifier
    implements AuthManagerService {
  FirebaseAuthManagerService();

  AnonymousUser? _user;

  AnonymousUser? get user => _user;

  initialize() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    firebaseAuth.userChanges().listen((firebaseUser) {
      _user = firebaseUser != null ? AnonymousUser(id: firebaseUser.uid) : null;

      notifyListeners();
    });

    try {
      await firebaseAuth.signInAnonymously();
    } on Exception catch (error) {
      print(error);
    }
  }
}
