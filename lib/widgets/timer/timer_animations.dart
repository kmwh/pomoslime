import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pomoslime/provider/theme_provider.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:pomoslime/provider/to_do_list_provider.dart';
import 'package:provider/provider.dart';

class TimerAnimations extends StatelessWidget {
  const TimerAnimations({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<ThemeProvider, TimerProvider, ToDoListProvider>(
      builder:
          (context, themeProvider, timerProvider, toDoListProvider, child) {
        return Lottie.asset(
          'assets/animations/slime_${toDoListProvider.currentToDoMap['icon'] ?? 'book'}_${themeProvider.darkMode ? 'white' : 'black'}.json',
          animate: timerProvider.isRunning,
          width: 220,
        );
      },
    );
  }
}
