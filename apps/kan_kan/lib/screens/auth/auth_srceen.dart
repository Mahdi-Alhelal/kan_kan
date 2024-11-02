import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan/cubit/auth_cubit/auth_cubit.dart';
import 'package:kan_kan/screens/home/home_screen.dart';
import 'package:kan_kan/widgets/custom_pinout.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/ui.dart';

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
              Text("تم إرسال كود التحقق إلى"),
              Text(email),
              SizedBox(
                height: 20,
              ),
              CustomPinput(
                onCompleted: (otp) async {
                  await cubitAuth.verifyEmailOtp(
                      email: email, otp: otp, type: type);
                },
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
                  // TODO: implement listener
                  if (state is AuthState) {
                    CircularProgressIndicator(
                      color: AppColor.primary,
                    );
                  }

                  if (state is SuccessAuthState) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (Route<dynamic> route) => false);
                  }

                  if (state is ErrorAuthState) {}
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
