import 'package:flutter/material.dart';
import 'package:kan_kan_admin/screen/home_screen.dart';
import 'package:kan_kan_admin/screen/users_screen.dart';
import 'package:ui/ui.dart';

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
                color: AppColor.bg,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: NavigationRail(
                  indicatorColor: AppColor.primary,
                  backgroundColor: Colors.transparent,
                  extended: true,
                  useIndicator: true,
                  minExtendedWidth: MediaQuery.of(context).size.width * .1,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      selectedIcon: Icon(
                        Icons.home_outlined,
                        color: Colors.white,
                      ),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.people),
                      selectedIcon: Icon(
                        Icons.people_outlined,
                        color: Colors.white,
                      ),
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
