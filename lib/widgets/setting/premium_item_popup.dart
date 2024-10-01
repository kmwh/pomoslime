import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pomoslime/provider/ad_provider.dart';
import 'package:provider/provider.dart';

class PremiumItemPopup extends StatelessWidget {
  final Function() onPressed;

  const PremiumItemPopup({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, top: 16, bottom: 7),
          child: Text(
            "premium_settings".tr(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          height: 58,
          child: Consumer<AdProvider>(
            builder: (context, provider, child) {
              return ElevatedButton(
                onPressed: provider.isPremium
                    ? () {
                        print(provider.premium);
                        print(DateTime.now());
                      }
                    : onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/crown.png",
                            width: 20,
                            color: const Color.fromARGB(255, 255, 217, 0),
                          ),
                          const SizedBox(width: 7),
                          Text(
                            "one_day_premium".tr(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color:
                                  Theme.of(context).colorScheme.secondaryFixed,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Image.asset(
                          "assets/images/${provider.isPremium ? "smile" : "key"}.png",
                          width: provider.isPremium ? 26 : 19,
                          color: Theme.of(context).colorScheme.secondaryFixed,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
