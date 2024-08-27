import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomoslime/model/calender_data_model.dart';
import 'package:pomoslime/model/user_data_model.dart';
import 'package:pomoslime/provider/background_usage_provider.dart';
import 'package:pomoslime/provider/calender_provider.dart';
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
  Hive.registerAdapter(CalenderDataModelAdapter());

  final userDataBox = await Hive.openBox<UserDataModel>("userData8");
  final calenderDataBox =
      await Hive.openBox<CalenderDataModel>("calenderData8");

  // 초기 설정 적용
  final userData = await initializeUserData(userDataBox);
  final calenderData = await initializeCalenderData(calenderDataBox);

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
        ChangeNotifierProvider(
          create: (context) => CalenderProvider(calenderData),
        ),
      ],
      child: const App(),
    ),
  );
}

// 초기 설정 함수
Future<UserDataModel> initializeUserData(Box<UserDataModel> box) async {
  if (box.isEmpty) {
    final defaultUserData = UserDataModel(
      premium: false,
      vibration: false,
      notificationIndex: 1,
      whiteNoiseIndex: 0,
      darkMode: false,
      backgroundUsage: true,
      language: 0,
      focusImmediately: false,
      toDoList: [
        ["pomodoro1", 13, 12, 5, 10, const Color(0xFFFFCC00).value],
        ["pomodoro2", 13, 12, 5, 10, const Color(0xFF2BFF00).value],
        ["pomodoro3", 13, 12, 5, 10, const Color(0xFF0026FF).value],
        ["pomodoro4", 13, 12, 5, 10, const Color(0xFF4800FF).value],
        ["pomodoro5", 13, 12, 5, 10, const Color(0xFFFF0000).value],
        ["pomodoro6", 13, 12, 5, 10, const Color(0xFFB700FF).value],
        ["pomodoro7", 13, 12, 5, 10, const Color(0xFFFFCC00).value],
        ["pomodoro8", 13, 12, 5, 10, const Color(0xFFFFCC00).value],
        ["pomodoro9", 13, 12, 5, 10, const Color(0xFFFFCC00).value],
      ],
      currentToDo: 0,
      currentSession: 0,
    );
    await box.put("userData", defaultUserData);
    return defaultUserData;
  } else {
    return box.get("userData")!;
  }
}

Future<CalenderDataModel> initializeCalenderData(
    Box<CalenderDataModel> box) async {
  if (box.isEmpty) {
    final defaultCalenderData = CalenderDataModel(
      focusTimeMap: {},
    );
    await box.put("calenderData", defaultCalenderData);
    return defaultCalenderData;
  } else {
    return box.get("calenderData")!;
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
