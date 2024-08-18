import 'package:flutter/material.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: SingleChildScrollView(),
    );
  }
}
