import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
            const SizedBox(height: 6),
            Text(
              "coffee_for_dev".tr(),
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.secondaryFixed,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/coffee.png",
                  width: 23,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 7),
                Text(
                  "coffee_price".tr(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Lottie.asset(
              "assets/animations/slime_rest_${context.read<ThemeProvider>().darkMode ? 'white' : 'black'}.json",
              width: 120,
            ),
            // const SizedBox(height: 16),
            // SizedBox(
            //   width: 250,
            //   child: Text(
            //     "premium_description".tr(),
            //     textAlign: TextAlign.center,
            //     style: const TextStyle(
            //       fontSize: 14,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PremiumPopupText(text: "remove_ads".tr()),
                SizedBox(height: 12),
                PremiumPopupText(text: "manage_multiple_to_do_lists".tr()),
                SizedBox(height: 12),
                PremiumPopupText(text: "enable_white_sound".tr()),
                SizedBox(height: 12),
                PremiumPopupText(text: "add_various_notification".tr()),
              ],
            ),
            const SizedBox(height: 34),
            CustomTextButton(
              text: "present_coffee".tr(),
              width: 210,
              verticalPadding: 16,
              fontSize: 15,
              onPressed: () {
                Navigator.pop(context);
                // context.read<AdProvider>().showRewardedAd(context);
              },
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
