import 'package:flutter/material.dart';
import "package:poker_income/Screens/simulation_tab_page.dart";
import "./common_widgets/analytics.dart";
import "./common_widgets/aqua_icons.dart";
import "./common_widgets/aqua_tab_bar.dart";
import "./common_widgets/aqua_tab_view.dart";
import "./view_models/simulation_session.dart";


class CalculatePage extends StatefulWidget {
  const CalculatePage({Key? key}) : super(key: key);

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {

  late ValueNotifier<CalculationSession> _calculationSession;

  @override
  void initState() {
    super.initState();

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
    return Scaffold(
    body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
         /*   Expanded(
              child: AquaTabView(
                views: [
                  SimulationTabPage(
                    key: ValueKey(0),
                    calculationSession: _calculationSession!,
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    ),
    );
  }
}
