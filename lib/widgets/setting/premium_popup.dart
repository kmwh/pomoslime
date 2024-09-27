import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pomoslime/provider/ad_provider.dart';
import 'package:pomoslime/provider/theme_provider.dart';
import 'package:pomoslime/widgets/custom/custom_text_button.dart';
import 'package:provider/provider.dart';

class PremiumPopup extends StatelessWidget {
  const PremiumPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
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
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(
                    "assets/images/cancel.png",
                    color: Theme.of(context).colorScheme.primary,
                    width: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              "one_day_premium".tr(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            Lottie.asset(
              "assets/animations/slime_rest_${context.read<ThemeProvider>().darkMode ? 'white' : 'black'}.json",
              width: 120,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 250,
              child: Text(
                "one_day_premium_description".tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: "CustomFont",
                ),
              ),
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/crown.png",
                      width: 24,
                      color: const Color.fromARGB(255, 255, 217, 0),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "remove_banner_ads".tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 172, 83, 255),
                        fontFamily: "CustomFont",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/crown.png",
                      width: 24,
                      color: const Color.fromARGB(255, 255, 217, 0),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "enable_white_sound".tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 172, 83, 255),
                        fontFamily: "CustomFont",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 34),
            CustomTextButton(
              text: "start_one_day_premium".tr(),
              width: 210,
              verticalPadding: 16,
              onPressed: () {
                Navigator.pop(context);
                context.read<AdProvider>().showRewardedAd(context);
              },
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
