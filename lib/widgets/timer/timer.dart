import 'package:flutter/material.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:provider/provider.dart';

class Timer extends StatefulWidget {
  const Timer({super.key});

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TimerProvider>(
      builder: (context, provider, child) {
        return Text(
          provider.formattedCurrentSessionSeconds,
          style: const TextStyle(
            fontSize: 70,
            fontWeight: FontWeight.w100,
          ),
        );
      },
    );
  }
}
