import 'package:flutter/material.dart';

class EditContent extends StatefulWidget {
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
  State<EditContent> createState() => _EditContentState();
}

class _EditContentState extends State<EditContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: (widget.currentValue - widget.timeUnit >=
                        widget.minValue)
                    ? () => widget.changeValueFunc(
                        widget.toDoKey, widget.currentValue - widget.timeUnit)
                    : null,
                icon: Image.asset(
                  "assets/images/arrow_left.png",
                  width: 24,
                  color: (widget.currentValue - widget.timeUnit >=
                          widget.minValue)
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primary.withOpacity(0.4),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "${widget.currentValue.toString()} ${widget.isMinute ? "min" : ""}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              IconButton(
                onPressed: (widget.currentValue + widget.timeUnit <=
                        widget.maxValue)
                    ? () => widget.changeValueFunc(
                        widget.toDoKey, widget.currentValue + widget.timeUnit)
                    : null,
                icon: Image.asset(
                  "assets/images/arrow.png",
                  width: 24,
                  color: (widget.currentValue + widget.timeUnit <=
                          widget.maxValue)
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
