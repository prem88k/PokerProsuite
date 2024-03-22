import "dart:async";
import "package:amplitude_flutter/amplitude.dart";
import "package:flutter/material.dart";

import "package:firebase_analytics/firebase_analytics.dart";
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/foundation.dart";
import "package:poker_income/service/amplitude_analytics_service.dart";
import "package:poker_income/service/firebase_auth_manager_service.dart";
import "package:poker_income/service/noop_error_reporter_service.dart";
import "package:poker_income/service/sentry_error_reporter_service.dart";

import "Screens/BottomNavigationBar.dart";
import "Screens/common_widgets/aqua_preferences.dart";
import "Screens/services/app.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authManagerService = FirebaseAuthManagerService();
  final amplitudeInstance = Amplitude.getInstance();
  final analyticsService = AmplitudeAnalyticsService(
    amplitudeAnalytics: amplitudeInstance,
    firebaseAnalytics: FirebaseAnalytics.instance,
  );
  final applicationPreferenceData = AquaPreferenceData();

  if (!kDebugMode) {
    final errorReporter = SentryErrorReporterService(
      sentryDsn:
      "https://7f698d26a29e495881c4adf639830a1a@o30395.ingest.sentry.io/5375048",
    );
    FlutterError.onError = (details) {
      errorReporter.captureFlutterException(details);
    };

    runZonedGuarded(() async {
      runApp(MaterialApp(
        home: AquaApp(
          analyticsService: analyticsService,
          authManagerService: authManagerService,
          errorReporter: errorReporter,
          applicationPreferenceData: applicationPreferenceData,
          prepare: () async {
            await Firebase.initializeApp();
            await authManagerService.initialize();
            await amplitudeInstance.init("94ba98446847f79253029f7f8e6d9cf3");
            await amplitudeInstance
                .setUserProperties({"Environment": "production"});
            await amplitudeInstance.trackingSessionEvents(true);
            await applicationPreferenceData.initialize();
          },
        ),
      ));
    }, (exception, stackTrace) async {
      errorReporter.captureException(
        exception: exception,
        stackTrace: stackTrace,
      );
    });
  } else {
    runApp( MaterialApp(
      home: AquaApp(
        analyticsService: analyticsService,
        authManagerService: authManagerService,
        errorReporter: NoopErrorReporterService(),
        applicationPreferenceData: applicationPreferenceData,
      ),
    ));
  }
}