import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pomoslime/model/calender_data_model.dart';
import 'package:pomoslime/model/user_data_model.dart';
import 'package:pomoslime/provider/notification_provider.dart';
import 'package:pomoslime/provider/background_usage_provider.dart';
import 'package:pomoslime/provider/calender_provider.dart';
import 'package:pomoslime/provider/focus_immediately_provider.dart';
import 'package:pomoslime/provider/language_provider.dart';
import 'package:pomoslime/provider/premium_provider.dart';
import 'package:pomoslime/provider/timer_provider.dart';
import 'package:pomoslime/provider/to_do_list_provider.dart';
import 'package:pomoslime/provider/vibration_provider.dart';
import 'package:pomoslime/provider/white_noise_provider.dart';
import 'package:pomoslime/screens/main_screen.dart';
import 'package:pomoslime/provider/theme_provider.dart';
import 'package:pomoslime/utils/ad_manager.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();
  // 광고 로드
  AdManager().loadBannerAd(0, "ca-app-pub-3940256099942544/9214589741");
  AdManager().loadBannerAd(1, "ca-app-pub-3940256099942544/9214589741");
  AdManager().loadBannerAd(2, "ca-app-pub-3940256099942544/9214589741");
  AdManager().loadBannerAd(3, "ca-app-pub-3940256099942544/9214589741");
  AdManager().loadRewardedAd("ca-app-pub-3940256099942544/5224354917");

  await EasyLocalization.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserDataModelAdapter());
  Hive.registerAdapter(CalenderDataModelAdapter());

  final userDataBox = await Hive.openBox<UserDataModel>("userData38");
  final calenderDataBox =
      await Hive.openBox<CalenderDataModel>("calenderData38");

  // 초기 설정 적용
  final userData = await initializeUserData(userDataBox);
  final calenderData = await initializeCalenderData(calenderDataBox);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ko')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => BackgroundUsageProvider(userData),
          ),
          ChangeNotifierProvider(
            create: (context) => CalenderProvider(calenderData),
          ),
          ChangeNotifierProvider(
            create: (context) => FocusImmediatelyProvider(userData),
          ),
          ChangeNotifierProvider(
            create: (context) => LanguageProvider(userData),
          ),
          ChangeNotifierProvider(
            create: (context) => NotificationProvider(userData),
          ),
          ChangeNotifierProvider(
            create: (context) => PremiumProvider(userData),
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
            create: (context) => WhiteNoiseProvider(userData),
          ),
        ],
        child: const App(),
      ),
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
      language: "English",
      focusImmediately: false,
      toDoList: [
        {
          "name": "pomo",
          "focusCount": 4,
          "focusTime": 25,
          "shortBreakTime": 5,
          "longBreakTime": 10,
          "timeUnit": 5,
          "icon": "book",
        },
      ],
      currentToDo: 0,
      currentSession: 0,
      currentTime: 1500,
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
      totalFocusTime: 0,
      todayFocusTime: 0,
      weekFocusTime: 0,
      monthFocusTime: 0,
      yearFocusTime: 0,
      numberView: false,
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
    final languageProvider = context.read<LanguageProvider>();
    languageProvider.selectLanguage(context, languageProvider.language);

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          theme: themeProvider.themeData,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: const MainScreen(),
        );
      },
    );
  }
}
