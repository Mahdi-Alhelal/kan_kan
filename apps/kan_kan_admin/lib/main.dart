import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kan_kan_admin/screen/home_screen.dart';
import 'package:kan_kan_admin/screen/navigation_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationPage());
  }
}
