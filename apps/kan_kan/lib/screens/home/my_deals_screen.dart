import 'package:flutter/material.dart';
import 'package:kan_kan/screens/home/profile_screen.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/ui.dart';


class MyDealsScreen extends StatelessWidget {
  const MyDealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColor.black.withOpacity(20 / 100),
                    child: const Icon(
                      Icons.person,
                      color: AppColor.white,
                    ),
                  ),
                  title: const Text(
                    "مرحباً بعودتك ، 👋",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    "علي التاروتي",
                    style: TextStyle(color: AppColor.secondary),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(8)),
                    width: context.getWidth(value: 0.45),
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      "صفقاتي",
                      style: TextStyle(color: AppColor.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColor.secondary,
                        borderRadius: BorderRadius.circular(8)),
                    width: context.getWidth(value: 0.45),
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      "صفقاتي السابقة",
                      style: TextStyle(color: AppColor.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
