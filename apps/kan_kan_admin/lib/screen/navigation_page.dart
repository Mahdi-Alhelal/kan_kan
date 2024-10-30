import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan_admin/cubits/navigation_cubit/navigation_cubit.dart';

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
          return BlocBuilder<NavigationCubit, NavigationState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  final f = FocusScope.of(context);

                  if (!f.hasPrimaryFocus) {
                    f.unfocus();
                  }
                },
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
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
                            onDestinationSelected: (value) =>
                                navigationCubit.navigationEvent(value: value),
                            selectedIndex: navigationCubit.index,
                            labelType: NavigationRailLabelType.none,
                            backgroundColor: Colors.transparent,
                            useIndicator: false,
                            minWidth: MediaQuery.of(context).size.width * .15,
                            destinations: [
                              NavigationRailDestination(
                                icon: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: const Text("الرئيسية")),
                                selectedIcon: const CustomSelectedIcon(
                                    text: "الريئيسية",
                                    icon: Icons.home_outlined),
                                label: const Text(''),
                              ),
                              NavigationRailDestination(
                                icon: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: const Text("العملاء")),
                                selectedIcon: const CustomSelectedIcon(
                                  icon: Icons.people_alt_outlined,
                                  text: "العملاء",
                                ),
                                label: const Text(""),
                              ),
                              NavigationRailDestination(
                                icon: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: const Text("المصانع")),
                                selectedIcon: const CustomSelectedIcon(
                                  icon: Icons.factory_outlined,
                                  text: "المصانع",
                                ),
                                label: const Text(""),
                              ),
                              NavigationRailDestination(
                                icon: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: const Text("الطلبات")),
                                selectedIcon: const CustomSelectedIcon(
                                  icon: Icons.receipt_outlined,
                                  text: "الطلبات",
                                ),
                                label: const Text(""),
                              ),
                              NavigationRailDestination(
                                icon: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: const Text("الصفقات")),
                                selectedIcon: const CustomSelectedIcon(
                                  icon: Icons.handshake_outlined,
                                  text: "الصفقات",
                                ),
                                label: const Text(""),
                              ),
                              NavigationRailDestination(
                                icon: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: const Text("المنتجات")),
                                selectedIcon: const CustomSelectedIcon(
                                  icon: Icons.tab_outlined,
                                  text: "المنتجات",
                                ),
                                label: const Text(""),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width * 0.80,
                            child:
                                navigationCubit.screens[navigationCubit.index])
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
