import 'package:flutter/material.dart';
import 'package:pomoslime/widgets/custom/custom_text_button.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function() onPressed;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: "CustomFont",
              ),
            ),
            const SizedBox(height: 15),
            Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: "CustomFont",
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextButton(
                  text: "ok".tr(),
                  fontSize: 14,
                  onPressed: onPressed,
                  horizontalPadding: 26,
                  verticalPadding: 12,
                ),
                const SizedBox(
                  width: 8,
                ),
                CustomTextButton(
                  text: "cancel".tr(),
                  fontSize: 14,
                  onPressed: () => Navigator.pop(context),
                  horizontalPadding: 26,
                  verticalPadding: 12,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
