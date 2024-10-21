import 'package:flutter/material.dart';
import 'package:kan_kan_admin/screen/home_screen.dart';
import 'package:kan_kan_admin/screen/users_screen.dart';

List<Widget> screens = const [HomeScreen(),UsersScreen()];

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                selectedIcon: Icon(Icons.home_outlined),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people),
                selectedIcon: Icon(Icons.people_outlined),
                label: Text('users'),
              ),
            ], selectedIndex: 1),
            const VerticalDivider(thickness: 1, width: 1),
            screens[1]
          ],
        ),
      ),
    );
  }
}
