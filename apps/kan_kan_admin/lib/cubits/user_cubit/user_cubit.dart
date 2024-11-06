import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/data/data_repository.dart';
import 'package:kan_kan_admin/integrations/supabase/supabase_client.dart';
import 'package:kan_kan_admin/layer/user_layer.dart';
import 'package:kan_kan_admin/model/user_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final userLayer = GetIt.I.get<UserLayer>();
  final api = DataRepository();
  //?--controller
  final TextEditingController userFullNameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPhoneController = TextEditingController();
  final TextEditingController userBalanceController = TextEditingController();

  //?-- table sort
  bool sort = true;
  int columnIndex = 0;

  String tmpStatus = "";
  //?-- cubit
  UserCubit() : super(UserInitial()) {
    addNewUser();
  }

  updateUserEvent(
      {required String userId,
      required String userStatus,
      required int index}) async {
    if (!isClosed) emit(LoadingUserState());

    try {
      final response = await api.updateUserProfile(
          userID: userId,
          status: userStatus,
          phone: userPhoneController.text.trim(),
          balance: double.parse(userBalanceController.text.trim()),
          fullName: userFullNameController.text.trim());
      if (response) {
        userLayer.usersList[index].userStatus = userStatus;
        userLayer.usersList[index].fullName =
            userFullNameController.text.trim();
        userLayer.usersList[index].phone = userPhoneController.text.trim();
        userLayer.usersList[index].balance =
            double.parse(userBalanceController.text.trim());
      }
      if (!isClosed) emit(SuccessUserState());
    } catch (errorMessage) {
      if (!isClosed) {
        emit(ErrorUserState(errorMessage: errorMessage.toString()));
      }
    }
  }

  updateUserStatusEvent({required int index}) async {
    try {
      final response = await api.updateUserStatus(
          userId: userLayer.usersList[index].userId, userStatus: tmpStatus);
      if (response) {
        userLayer.usersList[index].userStatus = tmpStatus;
      }
      if (!isClosed) emit(SuccessUserState());
    } catch (errorMessage) {
      if (!isClosed) {
        emit(ErrorUserState(errorMessage: errorMessage.toString()));
      }
    }
  }

  addNewUser() {
    KanSupabase.supabase.client
        .channel('add_user')
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            schema: 'public',
            table: 'users',
            callback: (newUser) {
              userLayer.usersList.add(UserModel.fromJson(newUser.newRecord));
              if (!isClosed) emit(SuccessUserState());
            })
        .subscribe();
  }

  sortEvent() {
    if (!isClosed) emit(SuccessSortState());
  }
}
