import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kan_kan_admin/data/repositories/deal_repository.dart';
import 'package:kan_kan_admin/integrations/supabase/supabase_client.dart';
import 'package:kan_kan_admin/model/models_2/deal_model.dart';
import 'package:kan_kan_admin/screen/navigation_page.dart';
import 'package:kan_kan_admin/setup/setup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ui/ui.dart';

void main() async {
  await EasyLocalization.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");
  // supabase = await Supabase.initialize(
  //   url: dotenv.env['SUPABASE_URL'] ?? '',
  //   anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  // );

  await setup();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
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
        locale: const Locale("ar"),
        home: const NavigationPage());
  }
}
