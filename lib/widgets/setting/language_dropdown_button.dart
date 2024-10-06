import 'package:flutter/material.dart';
import 'package:pomoslime/provider/backup_provider.dart';
import 'package:pomoslime/provider/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageDropdownButton extends StatelessWidget {
  const LanguageDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> languageItems = [
      "English",
      "한국어",
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: Image.asset(
                "assets/images/language.png",
                height: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              'language'.tr(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Consumer2<LanguageProvider, BackupProvider>(
          builder: (context, languageProvider, backupProvider, child) {
            languageProvider.changeLanguage(context);
            return Container(
              padding: const EdgeInsets.only(right: 10),
              width: 100,
              height: 40,
              child: DropdownButton<String>(
                value: languageProvider.language,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    languageProvider.selectLanguage(newValue);
                  }
                },
                items: languageItems.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    );
                  },
                ).toList(),
                isExpanded: true,
              ),
            );
          },
        ),
      ],
    );
  }
}
