import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan/cubit/user_nav/user_nav_cubit.dart';
import 'package:ui/ui.dart';

class ButtomNav extends StatelessWidget {
  const ButtomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserNavCubit(),
      child: Builder(builder: (context) {
        final cubitNav = context.read<UserNavCubit>();
        return BlocBuilder<UserNavCubit, UserNavState>(
          builder: (context, state) {
            const CircularProgressIndicator(
              color: AppColor.primary,
            );

            return Scaffold(
                body: cubitNav.screens[cubitNav.index],
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: AppColor.primary,
                  selectedItemColor: AppColor.third,
                  unselectedItemColor: AppColor.white,
                  currentIndex: cubitNav.index,
                  onTap: (int index) {
                    cubitNav.index = index;
                    cubitNav.updateEvent();
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'الرئيسية',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.handshake),
                      label: 'الصفقات',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'الملف الشخصي',
                    ),
                  ],
                )
                );
          },
        );
      }),
    );
  }
}
