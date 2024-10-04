import 'package:flutter/material.dart';
import 'package:pomoslime/provider/backup_provider.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:provider/provider.dart';

class Timer extends StatelessWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<TimerProvider, BackupProvider>(
      builder: (context, provider, backupProvider, child) {
        return Text(
          provider.formattedCurrentSessionSeconds,
          style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.w100,
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }
}
