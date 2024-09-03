import 'package:flutter/material.dart';

class LanguageMenu extends StatelessWidget {
  const LanguageMenu({super.key});

  @override
  Widget build(BuildContext context) {
    List<bool> selected = [];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ToggleButtons(
            borderRadius: BorderRadius.circular(8.0),
            borderWidth: 2,
            selectedBorderColor: Colors.blue,
            selectedColor: Colors.white,
            fillColor: Colors.blue,
            color: Colors.black,
            isSelected: selected,
            onPressed: (int index) {},
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text('English'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text('한국어'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
