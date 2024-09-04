import 'package:flutter/material.dart';

class NotificationMenu {
  static void showOptions(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {
                // Handle the action
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                // Handle the action
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_present),
              title: const Text('Documents'),
              onTap: () {
                // Handle the action
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
