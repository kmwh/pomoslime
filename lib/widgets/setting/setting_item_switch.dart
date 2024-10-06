import 'package:flutter/material.dart';

class SettingItemSwitch extends StatelessWidget {
  final bool initialValue;
  final String icon;
  final String text;
  final ValueChanged<bool> onChanged;

  const SettingItemSwitch({
    super.key,
    required this.initialValue,
    required this.icon,
    required this.text,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: Image.asset(
                  icon,
                  height: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Transform.scale(
            scale: 0.75,
            child: Switch(
              value: initialValue,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (bool value) {
                onChanged(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
