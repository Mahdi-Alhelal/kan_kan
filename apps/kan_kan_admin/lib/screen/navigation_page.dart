import 'package:flutter/material.dart';
import 'package:kan_kan_admin/data/repositories/address_repository.dart';
import 'package:kan_kan_admin/data/repositories/category_repository.dart';
import 'package:kan_kan_admin/data/repositories/factory_repository.dart';
import 'package:kan_kan_admin/data/repositories/order_repository.dart';
import 'package:kan_kan_admin/data/repositories/product_repository.dart';
import 'package:kan_kan_admin/screen/src/deals_screen.dart';
import 'package:kan_kan_admin/screen/src/factory_screen.dart';
import 'package:kan_kan_admin/screen/src/home_screen.dart';
import 'package:kan_kan_admin/screen/src/order_screen.dart';
import 'package:kan_kan_admin/screen/src/product_screen.dart';
import 'package:kan_kan_admin/screen/src/users_screen.dart';
import 'package:kan_kan_admin/widget/navigator/custom_selected_icon.dart';
import 'package:ui/ui.dart';

import '../data/repositories/auth_repository.dart';

List<Widget> screens = const [
  HomeScreen(),
  UsersScreen(),
  FactoryScreen(),
  OrderScreen(),
  DealsScreen(),
  ProductScreen(),
];
int index = 3;

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // AuthRepository().signUp(
    //     email: "tarooti14dev@gmail.com",
    //     fName: "Ali Altarouty",
    //     phoneNumber: "0597555447");

    // final x = AuthRepository()
    //     .verifyOtp(email: "tarooti14@gmail.com", otp: "380681", type: 1);
    // print(x);
    // AuthRepository().loginToken(email: "tarooti14@gmail.com");

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        bottom: false,
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                final x = await OrderRepository.addNewOrder(
                    userID: "83efec21-2fc7-416e-9825-a86a8af3a63a",
                    dealID: "89387763-f922-4c05-a372-2f9275238a9f",
                    addressID: "686e90ff-0a01-4f95-ad32-98ddd29ef96c",
                    amount: 300);
                print(x.toString());
              },
              child: Container(
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
            ),
            Container(
                margin: const EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width * 0.80,
                child: screens[index])
          ],
        ),
      ),
    );
  }
}
