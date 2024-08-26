import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomoslime/model/user_data_model.dart';
import 'package:pomoslime/provider/background_usage_provider.dart';
import 'package:pomoslime/provider/current_to_do_provider.dart';
import 'package:pomoslime/provider/focus_immediately_provider.dart';
import 'package:pomoslime/provider/language_provider.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:pomoslime/provider/to_do_list_provider.dart';
import 'package:pomoslime/provider/vibration_provider.dart';
import 'package:pomoslime/screens/main_screen.dart';
import 'package:pomoslime/provider/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserDataModelAdapter());

  final userDataBox = await Hive.openBox<UserDataModel>("userData4");

  // 초기 설정 적용
  final userData = await initializeSettings(userDataBox);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BackgroundUsageProvider(userData),
        ),
        ChangeNotifierProvider(
          create: (context) => CurrentToDoProvider(userData),
        ),
        ChangeNotifierProvider(
          create: (context) => FocusImmediatelyProvider(userData),
        ),
        ChangeNotifierProvider(
          create: (context) => LanguageProvider(userData),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(userData),
        ),
        ChangeNotifierProvider(
          create: (context) => TimerProvider(userData),
        ),
        ChangeNotifierProvider(
          create: (context) => ToDoListProvider(userData),
        ),
        ChangeNotifierProvider(
          create: (context) => VibrationProvider(userData),
        ),
      ],
      child: const App(),
    ),
  );
}

// 초기 설정 함수
Future<UserDataModel> initializeSettings(Box<UserDataModel> box) async {
  if (box.isEmpty) {
    final defaultSettings = UserDataModel(
      premium: false,
      vibration: false,
      notificationIndex: 1,
      whiteNoiseIndex: 0,
      darkMode: false,
      backgroundUsage: true,
      language: 0,
      focusImmediately: false,
      toDoMap: {
        "pomodoro": [13, 12, 5, 10],
      },
      currentToDo: ["pomodoro", 25, 12, 5, 10],
      currentSession: 0,
    );
    await box.put("settings", defaultSettings);
    return defaultSettings;
  } else {
    return box.get("settings")!;
  }
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
