import 'package:flutter/material.dart';
import 'package:pomoslime/screens/calender_screen.dart';
import 'package:pomoslime/screens/setting_screen.dart';
import 'package:pomoslime/screens/timer_screen.dart';

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
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            label: "timer",
            icon: Icon(
              Icons.timer_sharp,
            ),
          ),
          BottomNavigationBarItem(
            label: "calender",
            icon: Icon(
              Icons.calendar_month_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: "setting",
            icon: Icon(Icons.settings_outlined),
          ),
        ],
      ),
    );
  }
}
