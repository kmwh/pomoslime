import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_settings_model.dart';
import 'package:pomoslime/provider/theme_provider.dart';
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
  late UserSettingsModel _userSettings;

  @override
  void initState() {
    super.initState();
    _userSettings = Provider.of<UserSettingsModel>(context, listen: false);
  }

  // 각각의 설정마다 provider를 만드는 게 정석인 것 같기도 한데, 여기선 그냥 setState로 처리
  void _updateSetting(String key, bool value) {
    setState(() {
      switch (key) {
        case 'focusImmediately':
          _userSettings.focusImmediately = value;
          break;
        case 'vibration':
          _userSettings.vibration = value;
          break;
        case 'darkMode':
          Provider.of<ThemeProvider>(context, listen: false)
              .toggleTheme(_userSettings);
          break;
        case 'backgroundUsage':
          _userSettings.backgroundUsage = value;
          break;
      }
      _userSettings.save();
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
                  initialValue: _userSettings.focusImmediately,
                  icon: "assets/images/fire.png",
                  text: "휴식 후 집중 바로 시작",
                  onChanged: (value) {
                    _updateSetting('focusImmediately', value);
                  },
                ),
                SettingItemSwitch(
                  initialValue: _userSettings.vibration,
                  icon: "assets/images/vibration.png",
                  text: "진동",
                  onChanged: (value) {
                    _updateSetting('vibration', value);
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
              title: "앱 설정",
              children: [
                SettingItemSwitch(
                  initialValue: _userSettings.darkMode,
                  icon: "assets/images/moon.png",
                  text: "다크 모드",
                  onChanged: (value) {
                    _updateSetting('darkMode', value);
                  },
                ),
                SettingItemSwitch(
                  initialValue: _userSettings.backgroundUsage,
                  icon: "assets/images/timer.png",
                  text: "백그라운드 사용",
                  onChanged: (value) {
                    _updateSetting('backgroundUsage', value);
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
