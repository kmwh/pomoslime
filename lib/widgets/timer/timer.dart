import 'package:flutter/material.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:provider/provider.dart';

class Timer extends StatelessWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerProvider>(
      builder: (context, provider, child) {
        return Text(
          provider.formattedCurrentSessionSeconds,
          style: TextStyle(
            fontSize: 70,
            fontWeight: FontWeight.w100,
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }
}
