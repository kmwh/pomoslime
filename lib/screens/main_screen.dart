import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pomoslime/provider/ad_provider.dart';
import 'package:pomoslime/provider/backup_provider.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:pomoslime/screens/calender/calender_screen.dart';
import 'package:pomoslime/screens/settings/setting_screen.dart';
import 'package:pomoslime/screens/timer/timer_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens;

  _MainScreenState()
      : _screens = [
          const TimerScreen(),
          const CalenderScreen(),
          const SettingScreen(),
        ];

  void _onItemTapped(BuildContext context, int index) {
    setState(() {
      _selectedIndex = index;

      // 전면 광고 띄우기
      int randomNum = Random().nextInt(20);
      if (randomNum == 1) {
        context.read<AdProvider>().showInterstitialAd();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
          bottomNavigationBar: Consumer<TimerProvider>(
            builder: (context, provider, child) {
              return provider.isRunning
                  ? const SizedBox()
                  : Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerLowest),
                        ),
                      ),
                      child: BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        currentIndex: _selectedIndex,
                        onTap: (index) => _onItemTapped(context, index),
                        items: [
                          BottomNavigationBarItem(
                            label: "timer",
                            icon: Image.asset(
                              height: 34,
                              "assets/images/timer.png",
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          BottomNavigationBarItem(
                              label: "calender",
                              icon: Image.asset(
                                height: 34,
                                "assets/images/calender.png",
                                color: Theme.of(context).colorScheme.primary,
                              )),
                          BottomNavigationBarItem(
                            label: "setting",
                            icon: Image.asset(
                              height: 34,
                              "assets/images/setting.png",
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    );
            },
          ),
        ),
        // 로딩 화면
        Consumer<BackupProvider>(
          builder: (context, backupProvider, child) {
            if (backupProvider.isLoading) {
              return Stack(
                children: [
                  ModalBarrier(
                    color: Colors.black.withOpacity(0.4), // 반투명 오버레이
                    dismissible: false, // 터치 불가능하게 만듦
                  ),
                  Center(
                    child: CircularProgressIndicator(), // 로딩 인디케이터
                  ),
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
