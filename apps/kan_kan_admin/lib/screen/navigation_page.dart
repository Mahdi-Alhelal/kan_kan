import 'package:flutter/material.dart';
import 'package:kan_kan_admin/screen/src/deals_screen.dart';
import 'package:kan_kan_admin/screen/src/factory_screen.dart';
import 'package:kan_kan_admin/screen/src/home_screen.dart';
import 'package:kan_kan_admin/screen/src/order_screen.dart';
import 'package:kan_kan_admin/screen/src/product_screen.dart';
import 'package:kan_kan_admin/screen/src/users_screen.dart';
import 'package:kan_kan_admin/widget/navigator/custom_selected_icon.dart';
import 'package:ui/ui.dart';

List<Widget> screens = const [
  HomeScreen(),
  UsersScreen(),
  FactoryScreen(),
  OrderScreen(),
  DealsScreen(),
  ProductScreen(),
];
int index = 5;

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
                selectedIndex: index,
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
                  NavigationRailDestination(
                    icon: Text("المصانع"),
                    selectedIcon: CustomSelectedIcon(
                      icon: Icons.factory_outlined,
                      text: "المصانع",
                    ),
                    label: Text(""),
                  ),
                  NavigationRailDestination(
                    icon: Text("الطلبات"),
                    selectedIcon: CustomSelectedIcon(
                      icon: Icons.receipt_outlined,
                      text: "الطلبات",
                    ),
                    label: Text(""),
                  ),
                  NavigationRailDestination(
                    icon: Text("صفقات"),
                    selectedIcon: CustomSelectedIcon(
                      icon: Icons.handshake_outlined,
                      text: "صفقات",
                    ),
                    label: Text(""),
                  ),
                  NavigationRailDestination(
                    icon: Text("المنتجات"),
                    selectedIcon: CustomSelectedIcon(
                      icon: Icons.tab_outlined,
                      text: "المنتجات",
                    ),
                    label: Text(""),
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width * 0.84,
                child: screens[index])
          ],
        ),
      ),
    );
  }
}
