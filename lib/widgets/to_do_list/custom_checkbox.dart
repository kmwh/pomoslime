import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;
  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      side: WidgetStateBorderSide.resolveWith(
        (states) => BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.surfaceContainerLowest),
      ),
      checkColor: Colors.green,
      activeColor: Colors.transparent,
    );
  }
}
