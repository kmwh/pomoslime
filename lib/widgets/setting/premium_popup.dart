import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pomoslime/provider/ad_provider.dart';
import 'package:pomoslime/provider/theme_provider.dart';
import 'package:pomoslime/widgets/custom/custom_text_button.dart';
import 'package:pomoslime/widgets/setting/premium_popup_text.dart';
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
            Text(
              "one_day_premium".tr(),
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 20),
            Lottie.asset(
              "assets/animations/slime_rest_${context.read<ThemeProvider>().darkMode ? 'white' : 'black'}.json",
              width: 120,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "premium_description".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary.withAlpha(200),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PremiumPopupText(text: "remove_splash_ads".tr()),
                SizedBox(height: 12),
                PremiumPopupText(text: "remove_banner_ads".tr()),
              ],
            ),
            const SizedBox(height: 34),
            Consumer<AdProvider>(
              builder: (context, provider, child) {
                if (provider.isPremium) {
                  Navigator.pop(context);
                }
                return CustomTextButton(
                  text: "start_premium".tr(),
                  width: 210,
                  verticalPadding: 16,
                  fontSize: 15,
                  onPressed: () {
                    provider.showRewardedAd();
                  },
                );
              },
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
