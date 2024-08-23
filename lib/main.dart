import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomoslime/model/user_settings_model.dart';
import 'package:pomoslime/provider/background_usage_provider.dart';
import 'package:pomoslime/provider/focus_setting_provider.dart';
import 'package:pomoslime/provider/vibration_provider.dart';
import 'package:pomoslime/screens/main_screen.dart';
import 'package:pomoslime/provider/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserSettingsModelAdapter());

  final userSettingsBox = await Hive.openBox<UserSettingsModel>('userSettings');

  // 초기 설정 적용
  final userSettings = await initializeSettings(userSettingsBox);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(userSettings),
        ),
        ChangeNotifierProvider(
          create: (context) => FocusSettingProvider(userSettings),
        ),
        ChangeNotifierProvider(
          create: (context) => BackgroundUsageProvider(userSettings),
        ),
        ChangeNotifierProvider(
          create: (context) => VibrationProvider(userSettings),
        ),
      ],
      child: const App(),
    ),
  );
}

// 초기 설정 함수
Future<UserSettingsModel> initializeSettings(Box<UserSettingsModel> box) async {
  if (box.isEmpty) {
    final defaultSettings = UserSettingsModel(
      premium: false,
      vibration: false,
      notificationIndex: 1,
      whiteNoiseIndex: 0,
      darkMode: false,
      backgroundUsage: true,
      language: 'en',
      focusImmediately: false,
    );
    await box.put("settings", defaultSettings);
    return defaultSettings;
  }
  return box.get("settings")!;
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          theme: themeProvider.themeData,
          home: const MainScreen(),
        );
      },
    );
  }
}
