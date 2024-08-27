import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:pomoslime/provider/calender_provider.dart';
import 'package:pomoslime/widgets/calender/calender_tile.dart';
import 'package:provider/provider.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  List contents = [
    ["전체", 456789],
    ["오늘", 12],
    ["이번 주", 123],
    ["이번 달", 1234],
    ["이번 년도", 12345],
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 70,
        horizontal: 32,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: Text(
                "Focus Calender",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(height: 26),
            Consumer<CalenderProvider>(
              builder: (context, provider, child) {
                return HeatMap(
                  datasets: provider.focusTimeMap,
                  defaultColor: const Color.fromRGBO(129, 129, 129, 0.23),
                  colorMode: ColorMode.opacity,
                  showText: false,
                  showColorTip: false,
                  scrollable: true,
                  colorsets: const {
                    1: Color(0xFF39d353),
                  },
                  size: 20,
                );
              },
            ),
            const SizedBox(height: 10),
            ...contents.map((focusTime) {
              return Consumer<CalenderProvider>(
                builder: (context, provider, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: CalenderTile(
                      period: focusTime[0],
                      minutes: focusTime[1],
                    ),
                  );
                },
              );
            }),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
                    child: Image.asset(
                      "assets/images/download.png",
                      height: 28,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
                    child: Image.asset(
                      "assets/images/upload.png",
                      height: 28,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
