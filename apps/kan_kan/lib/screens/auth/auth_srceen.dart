import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan/check_screen.dart';
import 'package:kan_kan/cubit/auth_cubit/auth_cubit.dart';
import 'package:kan_kan/screens/buttom_nav.dart';
import 'package:kan_kan/widgets/alert.dart';
import 'package:kan_kan/widgets/custom_pinout.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/ui.dart';
import 'dart:ui' as ui;

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key, required this.email, required this.type});
  final String email;
  final int type;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(builder: (context) {
        final cubitAuth = context.read<AuthCubit>();
        return Scaffold(
          backgroundColor: AppColor.bg,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("تم إرسال كود التحقق إلى"),
              Text(email),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Directionality(
                  textDirection: ui.TextDirection.ltr,
                  child: CustomPinput(
                    onCompleted: (otp) async {
                      await cubitAuth.verifyEmailOtp(
                          email: email, otp: otp, type: type);
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: context.getWidth(value: 0.5),
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text("تحقق"))),
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthState) {
                    const CircularProgressIndicator(
                      color: AppColor.primary,
                    );
                  }
                  if (state is UserBlocked) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckScreen()),
                      (Route<dynamic> route) => false,
                    );
                  }

                  if (state is SuccessAuthState) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ButtomNav(),
                        ),
                        (Route<dynamic> route) => false);
                  }

                  if (state is ErrorAuthState) {
                    alert(
                        context: context,
                        msg: "❌ كود التحقق غير صحيح",
                        isCompleted: false);
                  }
                },
                child: const SizedBox(
                  height: 20,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
