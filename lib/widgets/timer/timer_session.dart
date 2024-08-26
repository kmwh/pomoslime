import 'package:flutter/material.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:provider/provider.dart';

class TimerSession extends StatelessWidget {
  const TimerSession({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> group = [];
    Widget widgetToAdd = const SizedBox();

    for (int i = 0; i <= context.read<TimerProvider>().totalSession; i++) {
      if (i % 2 == 0) {
        widgetToAdd = Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: (i < context.read<TimerProvider>().currentSession)
                ? Theme.of(context).colorScheme.secondary
                : null,
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 0.8,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        );
      } else if (i % 7 == 0) {
        widgetToAdd = const SizedBox(width: 8);
      } else {
        widgetToAdd = const SizedBox(width: 2.5);
      }
      group.add(widgetToAdd);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: group,
    );
  }
}
