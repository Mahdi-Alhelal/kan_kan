import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan_admin/cubits/navigation_cubit/navigation_cubit.dart';
import 'package:kan_kan_admin/screen/navigation_page.dart';
import 'package:ui/ui.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: Builder(builder: (context) {
        final navCubit = context.read<NavigationCubit>();
        return BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            return BlocListener<NavigationCubit, NavigationState>(
              listener: (context, state) {
                if (state is UpdateLanguage) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NavigationPage()));
                }
              },
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            context.setLocale(const Locale("ar"));

                            navCubit.updateLanguage();
                          },
                          child: const Text("العربي")),
                      ElevatedButton(
                          onPressed: () async {
                            context.setLocale(const Locale("en"));
                            await navCubit.updateLanguage();
                          },
                          child: const Text("English")),
                      ElevatedButton(
                          onPressed: () {
                            context.setLocale(const Locale("zh"));
                            navCubit.updateLanguage();
                          },
                          child: const Text("China"))
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
