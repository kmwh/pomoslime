import 'package:flutter/material.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:provider/provider.dart';

class TimerSession extends StatelessWidget {
  const TimerSession({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> group = [];
    Widget widgetToAdd = const SizedBox();

    List<Widget> setTimerSession(TimerProvider provider) {
      group = [];
      for (int i = 0; i < provider.totalSession; i++) {
        if ((i + 1) % 8 == 0 && i != 0) {
          widgetToAdd = const SizedBox(width: 8);
        } else if (i % 2 == 0) {
          widgetToAdd = Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              color: (i < provider.currentSession)
                  ? Theme.of(context).colorScheme.secondary
                  : null,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 0.8,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
          );
        } else {
          widgetToAdd = const SizedBox(width: 3);
        }
        group.add(widgetToAdd);
      }

      return group;
    }

    return Consumer<TimerProvider>(
      builder: (context, provider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: setTimerSession(provider),
        );
      },
    );
  }
}
