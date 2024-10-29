import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kan_kan/screens/auth/login_screen.dart';
import 'package:kan_kan/screens/home/deals_screen.dart';
import 'package:kan_kan/screens/home/home_screen.dart';
import 'package:kan_kan/screens/home/my_deals_screen.dart';
import 'package:kan_kan/setup/setup.dart';
import 'package:ui/ui.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  //await dotenv.load(fileName: ".env");
  await setup();

  runApp(
    EasyLocalization(
      supportedLocales: [const Locale('en'), const Locale('ar')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('ar'),
      child: DevicePreview(
        enabled: true,
        builder: (context) => const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: TAppTheme.lightTheme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: HomeScreen());
  }
}
