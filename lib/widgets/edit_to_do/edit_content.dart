import 'package:flutter/material.dart';

class EditContent extends StatelessWidget {
  final String text;
  final int timeUnit;
  final int currentValue;
  final int minValue;
  final int maxValue;
  final String toDoKey;
  final Function(String, dynamic) changeValueFunc;
  final bool isMinute;

  const EditContent({
    super.key,
    required this.text,
    required this.timeUnit,
    required this.currentValue,
    required this.maxValue,
    required this.minValue,
    required this.toDoKey,
    required this.changeValueFunc,
    this.isMinute = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: (currentValue - timeUnit >= minValue)
                    ? () => changeValueFunc(toDoKey, currentValue - timeUnit)
                    : null,
                icon: Image.asset(
                  "assets/images/arrow_left.png",
                  width: 24,
                  color: (currentValue - timeUnit >= minValue)
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primary.withOpacity(0.4),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "${currentValue.toString()} ${isMinute ? "min" : ""}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              IconButton(
                onPressed: (currentValue + timeUnit <= maxValue)
                    ? () => changeValueFunc(toDoKey, currentValue + timeUnit)
                    : null,
                icon: Image.asset(
                  "assets/images/arrow.png",
                  width: 24,
                  color: (currentValue + timeUnit <= maxValue)
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primary.withOpacity(0.4),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
