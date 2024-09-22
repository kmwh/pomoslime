import 'package:flutter/material.dart';

class SettingItemPopup extends StatelessWidget {
  final String icon;
  final String text;
  final Function() func;
  final bool? isCrown;
  final bool? hasColor;
  final bool? isLocked;

  const SettingItemPopup({
    super.key,
    required this.icon,
    required this.text,
    required this.func,
    this.isCrown,
    this.hasColor,
    this.isLocked,
  });

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
                icon,
                height: 24,
                color: hasColor == true
                    ? null
                    : (isCrown == true
                        ? const Color.fromARGB(255, 255, 208, 0)
                        : Theme.of(context).colorScheme.primary),
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
        InkWell(
          onTap: isLocked == true ? () {} : func,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
            child: isLocked == true
                ? Image.asset(
                    "assets/images/lock.png",
                    height: 26,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : Image.asset(
                    "assets/images/arrow.png",
                    height: 26,
                    color: Theme.of(context).colorScheme.primary,
                  ),
          ),
        ),
      ],
    );
  }
}
