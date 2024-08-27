import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pomoslime/provider/theme_provider.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:provider/provider.dart';

class TimerAnimations extends StatefulWidget {
  const TimerAnimations({super.key});

  @override
  State<TimerAnimations> createState() => _TimerAnimationsState();
}

class _TimerAnimationsState extends State<TimerAnimations> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Consumer<TimerProvider>(
          builder: (context, provider, child) {
            return Lottie.asset(
              'assets/animations/slime_book_${themeProvider.darkMode ? 'white' : 'black'}.json',
              animate: provider.isRunning,
              width: 220,
            );
          },
        );
      },
    );
  }
}
