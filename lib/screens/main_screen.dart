import 'package:flutter/material.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:pomoslime/screens/calender_screen.dart';
import 'package:pomoslime/screens/setting_screen.dart';
import 'package:pomoslime/screens/timer_screen.dart';
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onTap: _onItemTapped,
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
    );
  }
}
