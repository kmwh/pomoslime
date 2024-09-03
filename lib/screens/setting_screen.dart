import 'package:flutter/material.dart';
import 'package:pomoslime/provider/background_usage_provider.dart';
import 'package:pomoslime/provider/calender_provider.dart';
import 'package:pomoslime/provider/focus_immediately_provider.dart';
import 'package:pomoslime/provider/theme_provider.dart';
import 'package:pomoslime/provider/vibration_provider.dart';
import 'package:pomoslime/widgets/setting/language_menu.dart';
import 'package:pomoslime/widgets/setting/notification_menu.dart';
import 'package:pomoslime/widgets/setting/setting_item_popup.dart';
import 'package:pomoslime/widgets/setting/setting_item_switch.dart';
import 'package:pomoslime/widgets/setting/setting_menu.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  void showLanguageDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const LanguageMenu();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingMenu(
              title: "프리미엄 설정",
              children: [
                SettingItemPopup(
                  icon: "assets/images/crown.png",
                  text: "프리미엄",
                  func: () {},
                  isCrown: true,
                ),
                SettingItemPopup(
                  icon: "assets/images/refresh.png",
                  text: "결제 복구",
                  func: () {},
                ),
              ],
            ),
            SettingMenu(
              title: "타이머 설정",
              children: [
                SettingItemSwitch(
                  initialValue:
                      context.read<FocusImmediatelyProvider>().focusImmediately,
                  icon: "assets/images/fire.png",
                  text: "휴식 후 집중 바로 시작",
                  onChanged: (value) {
                    context.read<FocusImmediatelyProvider>().toggle();
                  },
                ),
                SettingItemSwitch(
                  initialValue: context.read<VibrationProvider>().vibration,
                  icon: "assets/images/vibration.png",
                  text: "진동",
                  onChanged: (value) {
                    context.read<VibrationProvider>().toggle();
                  },
                ),
                SettingItemPopup(
                  icon: "assets/images/notification.png",
                  text: "알림",
                  func: () => NotificationMenu.showOptions(context),
                ),
                SettingItemPopup(
                  icon: "assets/images/sound.png",
                  text: "백색소음",
                  func: () {},
                ),
              ],
            ),
            SettingMenu(
              title: "캘린더 설정",
              children: [
                SettingItemSwitch(
                  initialValue: context.read<CalenderProvider>().numberView,
                  icon: "assets/images/calender_date.png",
                  text: "캘린터 날짜 표시",
                  onChanged: (value) =>
                      context.read<CalenderProvider>().toggleNumberView(value),
                ),
              ],
            ),
            SettingMenu(
              title: "앱 설정",
              children: [
                SettingItemSwitch(
                  initialValue: context.read<ThemeProvider>().darkMode,
                  icon: "assets/images/moon.png",
                  text: "다크 모드",
                  onChanged: (value) => context.read<ThemeProvider>().toggle(),
                ),
                SettingItemSwitch(
                  initialValue:
                      context.read<BackgroundUsageProvider>().backgroundUsage,
                  icon: "assets/images/timer.png",
                  text: "백그라운드 사용",
                  onChanged: (value) {
                    context.read<BackgroundUsageProvider>().toggle();
                  },
                ),
                SettingItemPopup(
                  icon: "assets/images/security.png",
                  text: "권한 설정",
                  func: () {},
                ),
                SettingItemPopup(
                  icon: "assets/images/language.png",
                  text: "사용 언어",
                  func: () => showLanguageDialog(context),
                ),
              ],
            ),
            SettingMenu(
              title: "앱 정보",
              children: [
                SettingItemPopup(
                  icon: "assets/images/star.png",
                  text: "리뷰 작성하기",
                  func: () {},
                ),
                SettingItemPopup(
                  icon: "assets/images/manual.png",
                  text: "자주 묻는 질문",
                  func: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
