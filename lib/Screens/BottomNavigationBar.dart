import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poker_income/Screens/main_route.dart';
import 'package:poker_income/Screens/services/app.dart';
import "dart:async";
import "package:amplitude_flutter/amplitude.dart";
import "package:firebase_analytics/firebase_analytics.dart";
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/foundation.dart";
import "package:flutter/widgets.dart";
import 'package:cached_network_image/cached_network_image.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../Constants/Colors.dart';
import '../Presentation/PagerState.dart';
import '../service/amplitude_analytics_service.dart';
import '../service/firebase_auth_manager_service.dart';
import '../service/noop_error_reporter_service.dart';
import '../service/sentry_error_reporter_service.dart';
import 'CalculatePage.dart';
import 'CalculatorPage.dart';
import 'HomePage.dart';
import 'HostPage.dart';
import 'RoomChatPage.dart';
import 'MyGamesPage.dart';
import 'common_widgets/aqua_preferences.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  @override
  _BottomNavigationBarScreenState createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {


  int currentIndex = 0;
  final errorReporter = SentryErrorReporterService(
    sentryDsn:
    "https://7f698d26a29e495881c4adf639830a1a@o30395.ingest.sentry.io/5375048",
  );

  final authManagerService = FirebaseAuthManagerService();
  static Amplitude amplitudeInstance = Amplitude.getInstance();
  final analyticsService = AmplitudeAnalyticsService(
    amplitudeAnalytics: amplitudeInstance,
    firebaseAnalytics: FirebaseAnalytics.instance,
  );
  final applicationPreferenceData = AquaPreferenceData();

  /// Set a type current number a layout class
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return new HomePage();
      case 1:
        return new HostPage();
      case 2:
        return new MyGamesPage();
      case 3:
        return new RoomChatPage();
      case 4:
        return kDebugMode?AquaApp(
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
    ):AquaApp(
          analyticsService: analyticsService,
          authManagerService: authManagerService,
          errorReporter: NoopErrorReporterService(),
          applicationPreferenceData: applicationPreferenceData,
        );
      default:
        return HomePage();
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  /// Build BottomNavigationBar Widget
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return Scaffold(
      key: _scaffoldKey,
      body: callPage(currentIndex),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: secondaryColor,
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        itemShape: StadiumBorder(side: BorderSide.none),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home,color: currentIndex == 0?appColor:borderColor,),
            title: Text("Home",style:  TextStyle(
                fontFamily: 'work',
                fontSize: ScreenUtil().setHeight(13),
                fontWeight: FontWeight.bold,
                color:  currentIndex == 0?darkTextColor:borderColor),),
            selectedColor: primaryColor,

          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.add_circle,color: currentIndex == 1?appColor:borderColor,),
            title: Text("Host",style:  TextStyle(
                fontFamily: 'work',
                fontSize: ScreenUtil().setHeight(11),
                fontWeight: FontWeight.bold,
                color:  currentIndex == 1?darkTextColor:borderColor)),
            selectedColor:primaryColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.games,color: currentIndex == 2?appColor:borderColor,),
            title: Text("My Games",style:  TextStyle(
                fontFamily: 'work',
                fontSize: ScreenUtil().setHeight(11),
                fontWeight: FontWeight.bold,
                color:  currentIndex == 2?darkTextColor:borderColor)),
            selectedColor:primaryColor,
          ),
          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.chat,color: currentIndex == 3?appColor:borderColor,),
            title: Text("Chat",style:  TextStyle(
                fontFamily: 'work',
                fontSize: ScreenUtil().setHeight(11),
                fontWeight: FontWeight.bold,
                color:  currentIndex == 3?darkTextColor:borderColor)),
            selectedColor:primaryColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.calculate,color: currentIndex == 4?appColor:borderColor,),
            title: Text("Calculation",style:  TextStyle(
                fontFamily: 'work',
                fontSize: ScreenUtil().setHeight(11),
                fontWeight: FontWeight.bold,
                color:  currentIndex == 4?darkTextColor:borderColor)),
            selectedColor:primaryColor,
          ),
        ],
      ),
    );

  }

}
