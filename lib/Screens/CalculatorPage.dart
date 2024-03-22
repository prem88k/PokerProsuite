
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:poker_income/Screens/simulation_tab_page.dart";
import "package:poker_income/Screens/view_models/simulation_session.dart";

import "../preferences_tab_page.dart";
import "HomePage.dart";
import "HostPage.dart";
import "MyGamesPage.dart";
import "RoomChatPage.dart";
import "common_widgets/analytics.dart";
import "common_widgets/aqua_icons.dart";
import "common_widgets/aqua_tab_bar.dart";
import "common_widgets/aqua_tab_view.dart";

class MainRoute extends MaterialPageRoute {
  MainRoute({
    RouteSettings? settings,
  }) : super(
    builder: (context) => CalculatorPage(),
    settings: settings,
  );
}
class CalculatorPage extends StatefulWidget {
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  late int _activeTabViewIndex;

  /// A ValueNotifier that holds a CalculationSession inside.
  /// Replace the held CalculationSession to start a new session
  late ValueNotifier<CalculationSession> _calculationSession;

  @override
  void initState() {
    super.initState();

    _activeTabViewIndex = 0;

    late CalculationSession calculationSession;
    calculationSession = CalculationSession.initial(
      onStartCalculation: (_, __) {
        Analytics.of(context).logEvent(
          name: "Start Simulation",
          parameters: {
            "Number of Community Cards":
                calculationSession.communityCards.toSet().length,
            "Number of Hand Ranges": calculationSession.players.length,
          },
        );
      },
      onFinishCalculation: (snapshot) {
        Analytics.of(context).logEvent(
          name: "Finish Simulation",
          parameters: {
            "Number of Community Cards":
                calculationSession.communityCards.toSet().length,
            "Number of Hand Ranges": calculationSession.players.length,
          },
        );
      },
    );

    _calculationSession = ValueNotifier(calculationSession);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CalculationSession>(
      valueListenable: _calculationSession,
      builder: (context, calculationSession, _) => Container(
        height: 500,
        color: Color(0xffffffff),
        child: Column(
          children: [
            Expanded(
              child: AquaTabView(
                views: [
                  SimulationTabPage(
                    key: ValueKey(0),
                    calculationSession: calculationSession,
                  ),
                  HomePage(),
                  HostPage(),
                  MyGamesPage(),
                  RoomChatPage(),
                ],
                activeViewIndex: _activeTabViewIndex,
              ),
            ),
            AquaTabBar(
              activeIndex: _activeTabViewIndex,
              onChanged: (index) {
                setState(() {
                  _activeTabViewIndex = index;
                });
              },
              items: [
                AquaTabBarItem(label: "Calculation", icon: AquaIcons.percent),
                AquaTabBarItem(label: "Home", icon: AquaIcons.gear),
                AquaTabBarItem(label: "Host", icon: AquaIcons.gear),
                AquaTabBarItem(label: "My games", icon: AquaIcons.gear),
                AquaTabBarItem(label: "Chat", icon: AquaIcons.gear),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
