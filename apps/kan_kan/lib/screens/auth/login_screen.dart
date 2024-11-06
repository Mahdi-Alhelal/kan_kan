import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan/cubit/auth_cubit/auth_cubit.dart';
import 'package:kan_kan/screens/auth/auth_srceen.dart';
import 'package:kan_kan/screens/auth/register_screen.dart';
import 'package:kan_kan/widgets/alert.dart';
import 'package:ui/component/helper/custom_colors.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(builder: (context) {
        final cubitAuth = context.read<AuthCubit>();
        return Scaffold(
          backgroundColor: AppColor.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: context.getHeight(value: 0.5),
                  width: context.getWidth(),
                  decoration: const BoxDecoration(
                    color: AppColor.third,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Image.asset(
                        "assets/images/logo/kan_kan_logo.png",
                        width: context.getWidth(value: 0.75),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "تسجيل الدخول",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  title: "الإيميل",
                  controller: cubitAuth.emailController,
                  icon: const Icon(Icons.email),
                ),
                const SizedBox(height: 20),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    const CircularProgressIndicator(
                      color: AppColor.primary,
                    );
                    if (state is SuccessAuthState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AuthScreen(
                                  email: cubitAuth.emailController.text.trim(),
                                  type: 0,
                                )),
                      );
                    }
                    if (state is ErrorAuthState) {
                      alert(
                          context: context, msg: state.msg, isCompleted: false);
                    }
                  },
                  builder: (context, state) {
                    return state is LoadingAuthState
                        ? const CircularProgressIndicator(
                            color: AppColor.primary,
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: context.getWidth(value: 0.5),
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () async {
                                  await cubitAuth.eventLogin();
                                },
                                child: const Text(
                                  'دخول',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          );
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: const Text(
                    'لا تملك حساب',
                    style: TextStyle(
                      color:
                          AppColor.secondary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
