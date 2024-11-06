import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan/check_screen.dart';
import 'package:kan_kan/cubit/block_screen/block_cubit.dart';

class BlockScreen extends StatelessWidget {
  const BlockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlockCubit(),
      child: Builder(
        builder: (context) {
          return BlocListener<BlockCubit, BlockState>(
            listener: (context, state) {
              if (state is LogoutSuccess) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const CheckScreen()),
                  (Route<dynamic> route) => false,
                );
              }
            },
            child: Scaffold(
              body: SafeArea(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                          textAlign: TextAlign.center,
                          "نعتظر منكم,\n تم حضر حسابكم بسبب مخالفة سياية التطبيق"),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await context.read<BlockCubit>().logOutEvent();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.red),
                        ),
                        child: const Text("تسجيل خروح"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
