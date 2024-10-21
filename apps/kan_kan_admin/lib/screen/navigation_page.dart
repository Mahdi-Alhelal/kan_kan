import 'package:flutter/material.dart';
import 'package:kan_kan_admin/screen/home_screen.dart';
import 'package:kan_kan_admin/screen/users_screen.dart';

List<Widget> screens = const [HomeScreen(), UsersScreen()];

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xfff2f2f2),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: NavigationRail(
                  backgroundColor: Colors.transparent,
                  extended: true,
                  minExtendedWidth: MediaQuery.of(context).size.width * .1,
                  destinations: const [
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
                  ],
                  selectedIndex: 1),
            ),
            const VerticalDivider(
              thickness: .000001,
              width: 0,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.89,
                child: screens[1])
          ],
        ),
      ),
    );
  }
}
