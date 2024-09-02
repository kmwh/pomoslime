import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:pomoslime/provider/calender_provider.dart';
import 'package:pomoslime/widgets/calender/calender_backup_buttons.dart';
import 'package:pomoslime/widgets/calender/calender_tile.dart';
import 'package:provider/provider.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

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
            const SizedBox(height: 10),
            const CalenderTile(
              period: "전체",
              timeIndex: 0,
            ),
            const CalenderTile(
              period: "오늘",
              timeIndex: 1,
            ),
            const CalenderTile(
              period: "이번 주",
              timeIndex: 2,
            ),
            const CalenderTile(
              period: "이번 달",
              timeIndex: 3,
            ),
            const CalenderTile(
              period: "이번 년도",
              timeIndex: 4,
            ),
            const SizedBox(height: 18),
            const CalenderBackupButtons(),
          ],
        ),
      ),
    );
  }
}
