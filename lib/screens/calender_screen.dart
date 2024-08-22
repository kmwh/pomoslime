import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 32,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            HeatMap(
              datasets: {
                DateTime(2024, 8, 6): 1,
                DateTime(2024, 8, 7): 2,
                DateTime(2024, 8, 8): 3,
                DateTime(2024, 8, 9): 4,
                DateTime(2024, 8, 13): 5,
              },
              defaultColor: const Color.fromRGBO(129, 129, 129, 0.23),
              colorMode: ColorMode.opacity,
              showText: false,
              showColorTip: false,
              scrollable: true,
              colorsets: const {
                1: Color.fromARGB(255, 65, 182, 29),
              },
              size: 21,
            ),
          ],
        ),
      ),
    );
  }
}
