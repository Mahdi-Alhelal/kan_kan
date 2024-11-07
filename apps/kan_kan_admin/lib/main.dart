import 'package:flutter/material.dart';
import 'package:kan_kan_admin/screen/src/splash_screen.dart';
import 'package:kan_kan_admin/setup/setup.dart';
import 'package:ui/ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setup();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar'), Locale('zh')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar'),
        child: const MainApp()),
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
        home: const SplashScreen());
  }
}
