import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class EditIconOptions extends StatelessWidget {
  final String currentIcon;
  final Function(String, dynamic) onTap;

  const EditIconOptions({
    super.key,
    required this.currentIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<String> iconOptions = [
      'book',
      'palette',
      'hourglass',
      'laptop',
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              left: 22,
              right: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 30,
                ),
                Text(
                  "to_do".tr(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: iconOptions.map((icon) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 6,
                ),
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceBright,
                    borderRadius: BorderRadius.circular(12),
                    border: icon == currentIcon
                        ? Border.all(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            width: 0.9,
                          )
                        : null,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      onTap('icon', icon);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        "assets/images/$icon.png",
                        width: 36,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
