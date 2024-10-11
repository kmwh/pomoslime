import 'package:flutter/material.dart';
import 'package:pomoslime/provider/ad_provider.dart';
import 'package:pomoslime/provider/background_usage_provider.dart';
import 'package:pomoslime/provider/backup_provider.dart';
import 'package:pomoslime/provider/calender_provider.dart';
import 'package:pomoslime/provider/focus_immediately_provider.dart';
import 'package:pomoslime/provider/language_provider.dart';
import 'package:pomoslime/provider/payment_provider.dart';
import 'package:pomoslime/provider/sign_in_provider.dart';
import 'package:pomoslime/provider/theme_provider.dart';
import 'package:pomoslime/provider/vibration_provider.dart';
import 'package:pomoslime/widgets/custom/custom_dialog.dart';
import 'package:pomoslime/widgets/setting/account_menu.dart';
import 'package:pomoslime/widgets/setting/language_dropdown_button.dart';
import 'package:pomoslime/widgets/setting/notification_menu.dart';
import 'package:pomoslime/widgets/setting/premium_item_popup.dart';
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

  void showLogoutPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: "google_logout".tr(),
          content: "google_logout_content".tr(),
          onPressed: () {
            context.read<SignInProvider>().signOut();
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void showAccountMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const AccountMenu();
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
          builder: (context, languageProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<SignInProvider>(
                  builder: (context, provider, child) {
                    return SettingMenu(
                      title: "account_settings".tr(),
                      children: [
                        Consumer<PaymentProvider>(
                          builder: (context, adProvider, child) {
                            return SettingItemPopup(
                              icon:
                                  "assets/images/${adProvider.isPremium ? "coffee" : "user"}.png",
                              text: provider.loggedIn
                                  ? provider.displayName
                                  : "guest".tr(),
                              func: null,
                            );
                          },
                        ),
                        SettingItemPopup(
                          icon:
                              "assets/images/${provider.loggedIn ? "logout" : "login"}.png",
                          text: provider.loggedIn
                              ? "google_logout".tr()
                              : "google_login".tr(),
                          func: () => provider.loggedIn
                              ? showLogoutPopup(context)
                              : provider.signInWithGoogle(),
                        ),
                        SettingItemPopup(
                          icon: "assets/images/cloud.png",
                          text: "backup_restore".tr(),
                          func: () => showAccountMenu(context),
                          isLocked: !provider.loggedIn,
                        ),
                        Consumer<PaymentProvider>(
                          builder: (context, adProvider, child) {
                            return adProvider.isPremium
                                ? SizedBox.shrink()
                                : SettingItemPopup(
                                    icon: "assets/images/refresh.png",
                                    text: "restore_payment".tr(),
                                    func: () {},
                                    isLocked: !provider.loggedIn,
                                  );
                          },
                        ),
                      ],
                    );
                  },
                ),
                Consumer<PaymentProvider>(
                  builder: (context, provider, child) {
                    return provider.isPremium
                        ? SizedBox.shrink()
                        : PremiumItemPopup(
                            onPressed: () => showPremiumPopup(context),
                          );
                  },
                ),
                SettingMenu(
                  title: "timer_settings".tr(),
                  children: [
                    Consumer2<FocusImmediatelyProvider, BackupProvider>(
                      builder: (context, provider, backupProvider, child) {
                        return SettingItemSwitch(
                          initialValue: provider.focusImmediately,
                          icon: "assets/images/fire.png",
                          text: "focus_immediately_after_resting".tr(),
                          onChanged: (value) => provider.toggle(),
                        );
                      },
                    ),
                    Consumer2<VibrationProvider, BackupProvider>(
                      builder: (context, provider, backupProvider, child) {
                        return SettingItemSwitch(
                          initialValue: provider.vibration,
                          icon: "assets/images/vibration.png",
                          text: "vibration".tr(),
                          onChanged: (value) => provider.toggle(),
                        );
                      },
                    ),
                    SettingItemPopup(
                      icon: "assets/images/notification.png",
                      text: "notification".tr(),
                      func: () => showNotificationMenu(context),
                    ),
                    Consumer<PaymentProvider>(
                      builder: (context, provider, child) {
                        return SettingItemPopup(
                          icon: "assets/images/sound.png",
                          text: "white_noise".tr(),
                          func: () => showWhiteNoiseMenu(context),
                          isLocked: !provider.isPremium,
                        );
                      },
                    ),
                  ],
                ),
                SettingMenu(
                  title: "calendar_settings".tr(),
                  children: [
                    Consumer2<CalenderProvider, BackupProvider>(
                      builder: (context, provider, backupProvider, child) {
                        return SettingItemSwitch(
                          initialValue: provider.numberView,
                          icon: "assets/images/calender_date.png",
                          text: "date_display".tr(),
                          onChanged: (value) =>
                              provider.toggleNumberView(value),
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<AdProvider>(
                      builder: (context, provider, child) =>
                          provider.getBannerAdWidget(),
                    ),
                  ],
                ),
                SettingMenu(
                  title: "app_settings".tr(),
                  children: [
                    Consumer2<ThemeProvider, BackupProvider>(
                      builder: (context, provider, backupProvider, child) {
                        return SettingItemSwitch(
                          initialValue: provider.darkMode,
                          icon: "assets/images/moon.png",
                          text: "dark_mode".tr(),
                          onChanged: (value) => provider.toggle(),
                        );
                      },
                    ),
                    Consumer2<BackgroundUsageProvider, BackupProvider>(
                      builder: (context, provider, backupProvider, child) {
                        return SettingItemSwitch(
                          initialValue: provider.backgroundUsage,
                          icon: "assets/images/timer.png",
                          text: "use_in_background".tr(),
                          onChanged: (value) => provider.toggle(),
                        );
                      },
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
