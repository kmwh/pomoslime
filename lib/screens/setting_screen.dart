import 'package:flutter/material.dart';
import 'package:pomoslime/theme/theme_provider.dart';
import 'package:pomoslime/widgets/setting/notification_menu.dart';
import 'package:pomoslime/widgets/setting/setting_item_popup.dart';
import 'package:pomoslime/widgets/setting/setting_item_switch.dart';
import 'package:pomoslime/widgets/setting/setting_menu.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool startImmediately = false;
  bool vibration = false;
  bool darkMode = false;
  bool backgroundUse = false;
  bool verified = false;

  void setStartImmediately(bool value) {
    setState(() {
      startImmediately = value;
    });
  }

  void setVibration(bool value) {
    setState(() {
      vibration = value;
    });
  }

  void setDarkMode(bool value) {
    setState(() {
      darkMode = value;
      Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
    });
  }

  void setBackgroundUse(bool value) {
    setState(() {
      backgroundUse = value;
    });
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
              title: "계정 설정",
              children: [
                SettingItemPopup(
                  icon: "assets/images/crown.png",
                  text: "프리미엄",
                  func: () {},
                  isCrown: true,
                ),
                SettingItemPopup(
                  icon: "assets/images/download.png",
                  text: "데이터 백업하기",
                  func: () {},
                ),
                SettingItemPopup(
                  icon: "assets/images/upload.png",
                  text: "데이터 불러오기",
                  func: () {},
                ),
              ],
            ),
            SettingMenu(
              title: "타이머 설정",
              children: [
                SettingItemSwitch(
                  initialValue: startImmediately,
                  icon: "assets/images/fire.png",
                  text: "휴식 후 집중 바로 시작",
                  onChanged: setStartImmediately,
                ),
                SettingItemSwitch(
                  initialValue: vibration,
                  icon: "assets/images/vibration.png",
                  text: "진동",
                  onChanged: setVibration,
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
              title: "앱 설정",
              children: [
                SettingItemSwitch(
                  initialValue: darkMode,
                  icon: "assets/images/moon.png",
                  text: "다크 모드",
                  onChanged: setDarkMode,
                ),
                SettingItemSwitch(
                  initialValue: backgroundUse,
                  icon: "assets/images/timer.png",
                  text: "백그라운드 사용",
                  onChanged: setBackgroundUse,
                ),
                SettingItemPopup(
                  icon: "assets/images/security.png",
                  text: "권한 설정",
                  func: () {},
                ),
                SettingItemPopup(
                  icon: "assets/images/language.png",
                  text: "사용 언어",
                  func: () {},
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
