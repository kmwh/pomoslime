import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pomoslime/provider/notification_provider.dart';
import 'package:provider/provider.dart';

class NotificationMenu extends StatelessWidget {
  const NotificationMenu({super.key});

  Widget _notificationOption(
      BuildContext context, int index, String label, String icon) {
    return Consumer<NotificationProvider>(
      builder: (context, provider, child) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceBright,
            borderRadius: BorderRadius.circular(12),
            border: provider.notificationIndex == index
                ? Border.all(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    width: 0.9,
                  )
                : null,
          ),
          child: InkWell(
            onTap: () => provider.setNotification(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/$icon.png",
                  width: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> sounds = [
      ['None', 'sound'],
      ['Sound 1', 'sound'],
      ['Sound 2', 'sound'],
      ['Sound 3', 'sound'],
      ['Sound 4', 'sound'],
      ['Sound 5', 'sound'],
      ['Sound 6', 'sound'],
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
                  "notification".tr(),
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
          GridView.builder(
            shrinkWrap: true,
            itemCount: sounds.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1 / 1,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              return _notificationOption(
                  context, index, sounds[index][0], sounds[index][1]);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
