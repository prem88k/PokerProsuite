
import "package:flutter/cupertino.dart";

import "Screens/common_widgets/analytics.dart";
import "Screens/common_widgets/aqua_preferences.dart";
import "Screens/common_widgets/aqua_scaffold.dart";
import "Screens/common_widgets/aqua_theme.dart";
import "Screens/utilities/system_ui_overlay_style.dart";

class PreferencesTabPage extends StatefulWidget {
  PreferencesTabPage({Key? key}) : super(key: key);

  @override
  State<PreferencesTabPage> createState() => _PreferencesTabPageState();
}

class _PreferencesTabPageState extends State<PreferencesTabPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Analytics.of(context).logScreenChange(
        screenName: "Preferences Screen",
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final theme = AquaTheme.of(context);

    setSystemUIOverlayStyle(
      topColor: theme.scaffoldStyle.backgroundColor,
      bottomColor: theme.scaffoldStyle.backgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = AquaTheme.of(context);
    final preferences = AquaPreferences.of(context);

    return AquaScadffold(
      title: "Preferences",
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Calculation",
                  style: theme.textStyleSet.headline,
                ),
                SizedBox(height: 16.0),
                AnimatedBuilder(
                  animation: preferences,
                  builder: (context, _) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Display in Equity",
                                style: theme.textStyleSet.body,
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                preferences.prefersWinRate
                                    ? "Shows both win and tie rate.\n\"Win\" is you're the only player who got the pot. \"Tie\" is when you share the pot with others."
                                    : "Shows how many probability of shares for the pot you have.",
                                style: theme.textStyleSet.caption,
                              ),
                            ],
                          ),
                        ),
                        CupertinoSwitch(
                          value: !preferences.prefersWinRate,
                          onChanged: (value) {
                            preferences.setPreferWinRate(!value);
                          },
                          // TODO:
                          // create a style class for those colors
                          // probably including whole this preferences widgets
                          activeColor:
                              theme.buttonStyleSet.primary.backgroundColor,
                          trackColor: theme.playingCardStyle.backgroundColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
