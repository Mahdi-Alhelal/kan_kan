import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan/cubit/home_cubit/home_cubit.dart';
import 'package:kan_kan/screens/home/profile_screen.dart';
import 'package:kan_kan/widgets/deal_card.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/ui.dart';

import 'deal_details_screen.dart';

class DealsScreen extends StatelessWidget {
  const DealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAllActiveDeals(),
      child: Builder(builder: (context) {
        final cubitHome = context.read<HomeCubit>();
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
                    child: cubitHome.userLayer.email != ""
                        ? ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  AppColor.black.withOpacity(20 / 100),
                              child: const Icon(
                                Icons.person,
                                color: AppColor.white,
                              ),
                            ),
                            title: const Text(
                              "مرحباً بعودتك ، 👋",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              cubitHome.userLayer.user.fullName,
                              style: const TextStyle(color: AppColor.secondary),
                            ),
                          )
                        : const SizedBox(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              cubitHome.getAllActiveDeals();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: cubitHome.isClicked == 0
                                      ? AppColor.secondary
                                      : AppColor.primary,
                                  borderRadius: BorderRadius.circular(8)),
                              width: context.getWidth(value: 0.45),
                              height: 50,
                              alignment: Alignment.center,
                              child: const Text(
                                "الصفقات الحالية",
                                style: TextStyle(color: AppColor.white),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cubitHome.getAllPreviosDeals();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: cubitHome.isClicked == 0
                                      ? AppColor.primary
                                      : AppColor.secondary,
                                  borderRadius: BorderRadius.circular(8)),
                              width: context.getWidth(value: 0.45),
                              height: 50,
                              alignment: Alignment.center,
                              child: const Text(
                                "الصفقات السابقة",
                                style: TextStyle(color: AppColor.white),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cubitHome.deals.length,
                        itemBuilder: (BuildContext context, int index) {
                          return DealCard(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DealDetailsScreen(
                                    dealData: cubitHome.dealLayer.deals[index],
                                  ),
                                ),
                              );
                            },
                            dealData: cubitHome.deals[index],
                            title: cubitHome.deals[index].dealTitle,
                            orderBooked: cubitHome.deals[index].numberOfOrder,
                            orderMax: cubitHome.deals[index].quantity,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
