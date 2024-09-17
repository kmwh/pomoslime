import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pomoslime/provider/theme_provider.dart';
import 'package:pomoslime/widgets/setting/premium_text_content.dart';
import 'package:provider/provider.dart';

class PremiumPopup extends StatelessWidget {
  const PremiumPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
            const SizedBox(height: 10),
            Image.asset(
              "assets/images/crown.png",
              width: 40,
            ),
            const SizedBox(height: 10),
            Text(
              "premium_plan".tr(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 30),
            Lottie.asset(
              "assets/animations/slime_rest_${context.read<ThemeProvider>().darkMode ? 'white' : 'black'}.json",
              width: 120,
            ),
            const SizedBox(height: 30),
            const PremiumTextContent(
              text: "개발자에게 커피 한 잔 선물하기",
            ),
            const PremiumTextContent(
              text: "집중 캘린더 기능 해금",
            ),
            const PremiumTextContent(
              text: "유료 백색소음 소리 해금",
            ),
            const PremiumTextContent(
              text: "유료 타이머 알람 소리 해금",
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
