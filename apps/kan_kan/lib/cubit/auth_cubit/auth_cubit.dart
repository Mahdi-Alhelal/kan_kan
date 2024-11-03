import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan/data/data_repository.dart';
import 'package:kan_kan/layer/user_data_layer.dart';
import 'package:kan_kan/model/user_model.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fullController = TextEditingController();
  final userLayer = GetIt.I.get<UserDataLayer>();

  AuthCubit() : super(AuthInitial());
  void loginCurrentUser() async {
    await Future.delayed(Duration.zero);
    emit(LoadingAuthState());

    try {
      userLayer.email = DataRepository().getCurrentUser();
      if (userLayer.email != "") {
        await DataRepository().loginToken(email: userLayer.email);

        if (userLayer.user.email != "") {
          userLayer.email = userLayer.user.email;
          emit(SuccessAuthState());
        }
      } else {
        emit(LoginAuthState());
      }
    } catch (error) {
      emit(ErrorAuthState(msg: error.toString()));
    }
  }

  signup() async {
    print("here");
    await Future.delayed(Duration.zero);
    emit(LoadingAuthState());
    try {
      print("inside");
      UserModel userDetails = UserModel(
          userId: "",
          fullName: fullController.text.trim(),
          email: emailController.text.trim(),
          phone: phoneController.text.trim(),
          balance: 0,
          userStatus: "active",
          role: "user");
      final response = await DataRepository().signUp(userDetails: userDetails);
      if (response) {
        userLayer.user = userDetails;
      }
      emit(SuccessAuthState());
    } catch (e) {
      emit(ErrorAuthState(msg: "Error e"));
      print(e);
    }
  }

  verifyEmailOtp(
      {required String email, required String otp, required int type}) async {
    await Future.delayed(Duration.zero);

    emit(LoadingAuthState());
    try {
      UserModel result = await DataRepository().verifyOtp(
        type: type,
        email: email,
        otp: otp,
      );
      userLayer.user = result;
      userLayer.email = userLayer.user.email;
      emit(SuccessAuthState());
    } catch (error) {
      // Handle any errors during the process
      emit(ErrorAuthState(msg: "Error e"));
      print(error);
    }
  }

  Future eventLogin() async {
    await Future.delayed(Duration.zero);
    emit(LoadingAuthState());
    try {
      // Call the repository function to send the OTP to the email
      bool status =
          await DataRepository().login(email: emailController.text.trim());
      status == true
          ? emit(SuccessAuthState())
          : emit(ErrorAuthState(msg: "عذراً، الإيميل مسجّل من قبل 😞"));
    } catch (error) {
      emit(ErrorAuthState(msg: 'Failed to send OTP. Please try again.'));
    }
  }
}
