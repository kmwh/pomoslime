import 'package:flutter/material.dart';
import 'package:pomoslime/provider/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageMenu extends StatelessWidget {
  const LanguageMenu({super.key});

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
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(right: 10),
          width: 100,
          child: DropdownButton<String>(
            value: context.read<LanguageProvider>().language,
            onChanged: (String? newValue) {
              if (newValue != null) {
                context
                    .read<LanguageProvider>()
                    .selectLanguage(context, newValue);
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
        )
      ],
    );
  }
}
