import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:pomoslime/provider/ad_provider.dart';
import 'package:pomoslime/provider/calender_provider.dart';
import 'package:pomoslime/provider/language_provider.dart';
import 'package:pomoslime/widgets/calender/calender_tile.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 13,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 72,
              right: 32,
              left: 32,
            ),
            child: Consumer<LanguageProvider>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    const Center(
                      child: Text(
                        "Focus Calender",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Consumer<CalenderProvider>(
                      builder: (context, provider, child) {
                        return HeatMap(
                          datasets: provider.focusTimeMap,
                          defaultColor:
                              const Color.fromRGBO(129, 129, 129, 0.23),
                          colorMode: ColorMode.opacity,
                          showText: provider.numberView,
                          showColorTip: false,
                          scrollable: true,
                          colorsets: const {
                            1: Color(0xFF39d353),
                          },
                          size: 20,
                        );
                      },
                    ),
                    const SizedBox(height: 14),
                    CalenderTile(
                      period: "total".tr(),
                      periodIndex: 0,
                    ),
                    CalenderTile(
                      period: "today".tr(),
                      periodIndex: 1,
                    ),
                    CalenderTile(
                      period: "this_week".tr(),
                      periodIndex: 2,
                    ),
                    CalenderTile(
                      period: "this_month".tr(),
                      periodIndex: 3,
                    ),
                    CalenderTile(
                      period: "this_year".tr(),
                      periodIndex: 4,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Consumer<AdProvider>(
            builder: (context, provider, child) =>
                provider.getBannerAdWidget(1),
          ),
        ),
      ],
    );
  }
}
