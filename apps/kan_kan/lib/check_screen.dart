import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan/cubit/auth_cubit/auth_cubit.dart';
import 'package:kan_kan/screens/buttom_nav.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..loginCurrentUser(),
      child: Builder(builder: (context) {
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoadingAuthState) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is SuccessAuthState || state is LoginAuthState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const ButtomNav()));
            }
          },
          child: const Scaffold(
            body: SafeArea(child: Center()),
          ),
        );
      }),
    );
  }
}
