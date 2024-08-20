import 'package:flutter/material.dart';
import 'package:pomoslime/widgets/setting/setting_item_popup.dart';
import 'package:pomoslime/widgets/setting/setting_item_switch.dart';
import 'package:pomoslime/widgets/setting/setting_menu.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _startImmediately = false;
  bool _vibration = false;
  bool _darkMode = false;
  bool _backgroundUse = false;
  bool verified = false;

  void setStartImmediately(bool value) {
    setState(() {
      _startImmediately = value;
    });
  }

  void setVibration(bool value) {
    setState(() {
      _vibration = value;
    });
  }

  void setDarkMode(bool value) {
    setState(() {
      _darkMode = value;
    });
  }

  void setBackgroundUse(bool value) {
    setState(() {
      _backgroundUse = value;
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
              title: "타이머 설정",
              children: [
                SettingItemSwitch(
                  initialValue: _startImmediately,
                  icon: "assets/images/fire.png",
                  text: "휴식 후 집중 바로 시작",
                  onChanged: setStartImmediately,
                ),
                SettingItemSwitch(
                  initialValue: _vibration,
                  icon: "assets/images/vibration.png",
                  text: "진동",
                  onChanged: setVibration,
                ),
                SettingItemPopup(
                  icon: "assets/images/notification.png",
                  text: "알림",
                  func: () {},
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
                  initialValue: _darkMode,
                  icon: "assets/images/moon.png",
                  text: "다크 모드",
                  onChanged: setDarkMode,
                ),
                SettingItemSwitch(
                  initialValue: _backgroundUse,
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
              title: "계정 설정",
              children: [
                SettingItemPopup(
                  icon: "assets/images/present.png",
                  text: "구독",
                  func: () {},
                ),
                SettingItemPopup(
                  icon: "assets/images/${verified ? "logout" : "login"}.png",
                  text: verified ? "로그아웃" : "로그인",
                  func: () {},
                ),
              ],
            ),
            SettingMenu(
              title: "앱 정보",
              children: [
                SettingItemPopup(
                  icon: "assets/images/manual.png",
                  text: "자주 묻는 질문",
                  func: () {},
                ),
                SettingItemPopup(
                  icon: "assets/images/star.png",
                  text: "리뷰 작성하기",
                  func: () {},
                ),
                SettingItemPopup(
                  icon: "assets/images/info.png",
                  text: "이용약관",
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
