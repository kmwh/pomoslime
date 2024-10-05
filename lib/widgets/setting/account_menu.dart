import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pomoslime/provider/ad_provider.dart';
import 'package:pomoslime/provider/backup_provider.dart';
import 'package:provider/provider.dart';

class AccountMenu extends StatelessWidget {
  const AccountMenu({super.key});

  Widget backupButton(
      BuildContext context, String icon, String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            const SizedBox(width: 16),
            Image.asset(
              "assets/images/$icon.png",
              color: Theme.of(context).colorScheme.primary,
              width: 30,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void dataBackup(BuildContext context) {
    context.read<BackupProvider>().backupData(context);
    Navigator.pop(context);
    context.read<AdProvider>().showInterstitialAd();
  }

  void dataRestore(BuildContext context) {
    context.read<BackupProvider>().restoreData(context);
    Navigator.pop(context);
    context.read<AdProvider>().showInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                  "backup_restore".tr(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backupButton(
                context,
                "cloud_upload",
                "data_backup".tr(),
                () => dataBackup(context),
              ),
              backupButton(
                context,
                "cloud_download",
                "data_restore".tr(),
                () => dataRestore(context),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
