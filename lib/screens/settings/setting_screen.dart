import 'package:flutter/material.dart';
import 'package:pomoslime/provider/background_usage_provider.dart';
import 'package:pomoslime/provider/calender_provider.dart';
import 'package:pomoslime/provider/focus_immediately_provider.dart';
import 'package:pomoslime/provider/language_provider.dart';
import 'package:pomoslime/provider/theme_provider.dart';
import 'package:pomoslime/provider/vibration_provider.dart';
import 'package:pomoslime/utils/ad_manager.dart';
import 'package:pomoslime/widgets/setting/language_dropdown_button.dart';
import 'package:pomoslime/widgets/setting/notification_menu.dart';
import 'package:pomoslime/widgets/setting/premium_popup.dart';
import 'package:pomoslime/widgets/setting/setting_item_popup.dart';
import 'package:pomoslime/widgets/setting/setting_item_switch.dart';
import 'package:pomoslime/widgets/setting/setting_menu.dart';
import 'package:pomoslime/widgets/setting/white_noise_menu.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  void showPremiumPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const PremiumPopup();
      },
    );
  }

  void showNotificationMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const NotificationMenu();
      },
    );
  }

  void showWhiteNoiseMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const WhiteNoiseMenu();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 28,
      ),
      child: SingleChildScrollView(
        child: Consumer<LanguageProvider>(
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingMenu(
                  title: 'premium_settings'.tr(),
                  children: [
                    SettingItemPopup(
                      icon: "assets/images/crown.png",
                      text: 'premium'.tr(),
                      func: () => showPremiumPopup(context),
                      isCrown: true,
                    ),
                  ],
                ),
                SettingMenu(
                  title: "account_settings".tr(),
                  children: [
                    SettingItemPopup(
                      icon: "assets/images/drive.png",
                      text: "google_drive_backup".tr(),
                      func: () {},
                      hasColor: true,
                    ),
                  ],
                ),
                SettingMenu(
                  title: "timer_settings".tr(),
                  children: [
                    SettingItemSwitch(
                      initialValue: context
                          .read<FocusImmediatelyProvider>()
                          .focusImmediately,
                      icon: "assets/images/fire.png",
                      text: "focus_immediately_after_resting".tr(),
                      onChanged: (value) {
                        context.read<FocusImmediatelyProvider>().toggle();
                      },
                    ),
                    SettingItemSwitch(
                      initialValue: context.read<VibrationProvider>().vibration,
                      icon: "assets/images/vibration.png",
                      text: "vibration".tr(),
                      onChanged: (value) {
                        context.read<VibrationProvider>().toggle();
                      },
                    ),
                    SettingItemPopup(
                      icon: "assets/images/notification.png",
                      text: "notification".tr(),
                      func: () => showNotificationMenu(context),
                    ),
                    SettingItemPopup(
                      icon: "assets/images/sound.png",
                      text: "white_noise".tr(),
                      func: () => showWhiteNoiseMenu(context),
                    ),
                  ],
                ),
                SettingMenu(
                  title: "calendar_settings".tr(),
                  children: [
                    SettingItemSwitch(
                      initialValue: context.read<CalenderProvider>().numberView,
                      icon: "assets/images/calender_date.png",
                      text: "date_display".tr(),
                      onChanged: (value) => context
                          .read<CalenderProvider>()
                          .toggleNumberView(value),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AdManager().getBannerAdWidget(2),
                  ],
                ),
                SettingMenu(
                  title: "app_settings".tr(),
                  children: [
                    SettingItemSwitch(
                      initialValue: context.read<ThemeProvider>().darkMode,
                      icon: "assets/images/moon.png",
                      text: "dark_mode".tr(),
                      onChanged: (value) =>
                          context.read<ThemeProvider>().toggle(),
                    ),
                    SettingItemSwitch(
                      initialValue: context
                          .read<BackgroundUsageProvider>()
                          .backgroundUsage,
                      icon: "assets/images/timer.png",
                      text: "use_in_background".tr(),
                      onChanged: (value) {
                        context.read<BackgroundUsageProvider>().toggle();
                      },
                    ),
                    SettingItemPopup(
                      icon: "assets/images/security.png",
                      text: "permission_settings".tr(),
                      func: () {},
                    ),
                    const LanguageDropdownButton(),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
