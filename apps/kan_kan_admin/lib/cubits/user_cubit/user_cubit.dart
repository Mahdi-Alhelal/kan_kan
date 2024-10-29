import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/data/repositories/users_repository.dart';
import 'package:kan_kan_admin/layer/user_layer.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final userLayer = GetIt.I.get<UserLayer>();
  final TextEditingController userFullNameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPhoneController = TextEditingController();
  final TextEditingController userBalanceController = TextEditingController();

  UserCubit() : super(UserInitial());

  updateUserRoleEvent({required String userID, required String role}) {}
  updateUserEvent(
      {required String userID,
      required String fullName,
      required String phone,
      required String status,
      required String balance}) async {
    emit(LoadingUserState());
    double balanceToDouble = double.parse(balance);

    try {
      await UsersRepository.updateUserProfile(
          userID: userID,
          status: status,
          phone: phone,
          balance: balanceToDouble,
          fullName: fullName);
      emit(SuccessUserState());
    } catch (e) {
      print(e);
    }
  }
}
