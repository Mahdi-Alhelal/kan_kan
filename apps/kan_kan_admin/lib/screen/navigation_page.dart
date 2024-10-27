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

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: Builder(
        builder: (context) {
          final navigationCubit = context.read<NavigationCubit>();
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
              );
            },
          );
      ),
    );
  }
}
