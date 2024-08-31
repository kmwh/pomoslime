import 'package:flutter/material.dart';

class CalenderBackupButtons extends StatelessWidget {
  const CalenderBackupButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
            child: Image.asset(
              "assets/images/download.png",
              height: 28,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
            child: Image.asset(
              "assets/images/upload.png",
              height: 28,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
