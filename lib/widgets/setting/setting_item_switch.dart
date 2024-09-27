import 'package:flutter/material.dart';

class SettingItemSwitch extends StatefulWidget {
  final bool initialValue;
  final String icon;
  final String text;
  final ValueChanged<bool> onChanged;
  final bool hasColor;

  const SettingItemSwitch({
    super.key,
    required this.initialValue,
    required this.icon,
    required this.text,
    required this.onChanged,
    this.hasColor = false,
  });

  @override
  State<SettingItemSwitch> createState() => _SettingItemSwitchState();
}

class _SettingItemSwitchState extends State<SettingItemSwitch> {
  bool _isToggled = false;

  @override
  void initState() {
    super.initState();
    _isToggled = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: Image.asset(
                widget.icon,
                height: 24,
                color: widget.hasColor
                    ? null
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              widget.text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: "CustomFont",
              ),
            ),
          ],
        ),
        Transform.scale(
          scale: 0.75,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2.5),
            child: Switch(
              value: _isToggled,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (bool value) {
                setState(() {
                  _isToggled = value;
                });
                widget.onChanged(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}
