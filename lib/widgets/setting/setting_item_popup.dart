import 'package:flutter/material.dart';

class SettingItemPopup extends StatelessWidget {
  final String icon;
  final String text;
  final Function()? func;
  final bool? isLocked;
  final bool? hasColor;

  const SettingItemPopup({
    super.key,
    required this.icon,
    required this.text,
    required this.func,
    this.isLocked,
    this.hasColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Row(
            children: [
              Image.asset(
                icon,
                height: 24,
                color: hasColor == true
                    ? null
                    : Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 7),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        func == null
            ? SizedBox()
            : InkWell(
                onTap: isLocked == true ? () {} : func,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: isLocked == true
                      ? Image.asset(
                          "assets/images/lock.png",
                          height: 26,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : Image.asset(
                          "assets/images/arrow.png",
                          height: 28,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                ),
              ),
      ],
    );
  }
}
