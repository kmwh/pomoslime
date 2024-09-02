import 'package:flutter/material.dart';
import 'package:pomoslime/provider/calender_provider.dart';
import 'package:provider/provider.dart';

class CalenderTile extends StatelessWidget {
  final String period;
  final int timeIndex;

  const CalenderTile({
    super.key,
    required this.period,
    required this.timeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CalenderProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceBright,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 21,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    period,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    "${provider.getPeriodTimes(timeIndex)} min",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
