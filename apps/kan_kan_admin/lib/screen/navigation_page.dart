import 'package:flutter/material.dart';
import 'package:kan_kan_admin/screen/home_screen.dart';
import 'package:kan_kan_admin/screen/users_screen.dart';
import 'package:kan_kan_admin/widget/navigator/custom_selected_icon.dart';
import 'package:ui/ui.dart';

List<Widget> screens = const [HomeScreen(), UsersScreen()];

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 11),
              decoration: const BoxDecoration(
                color: AppColor.bg,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: NavigationRail(
                selectedIndex: 1,
                labelType: NavigationRailLabelType.none,
                backgroundColor: Colors.transparent,
                useIndicator: false,
                minWidth: MediaQuery.of(context).size.width * .15,
                destinations: const [
                  NavigationRailDestination(
                    icon: Text("صفحة الريئيسية"),
                    selectedIcon: CustomSelectedIcon(
                        text: "صفحة الريئيسية", icon: Icons.home_outlined),
                    label: Text(''),
                  ),
                  NavigationRailDestination(
                    icon: Text("مستخدمين"),
                    selectedIcon: CustomSelectedIcon(
                      icon: Icons.people_alt_outlined,
                      text: "مستخدمين",
                    ),
                    label: Text(""),
                  ),
                ],
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.84,
                child: screens[1])
          ],
        ),
      ),
    );
  }
}
