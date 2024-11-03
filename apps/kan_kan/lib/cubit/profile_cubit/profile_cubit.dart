import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan/data/data_repository.dart';
import 'package:kan_kan/layer/order_data_layer.dart';
import 'package:kan_kan/layer/user_data_layer.dart';
import 'package:kan_kan/model/order_model.dart';
import 'package:kan_kan/model/user_model.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final userLayer = GetIt.I.get<UserDataLayer>();
  final userOrders = GetIt.I.get<OrderDataLayer>();
  int ordersNow = 0;
  int preOrder = 0;

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();

  updateEvent() async {
    emit(LoadingProfileState());
    try {
      UserModel newUser = UserModel(
          userId: userLayer.user.userId,
          fullName: userLayer.user.fullName,
          email: userLayer.user.email,
          phone: controllerPhone.text,
          balance: userLayer.user.balance,
          userStatus: userLayer.user.userStatus,
          role: userLayer.user.userStatus);
      userLayer.user = await DataRepository().updateProfile(user: newUser);
      emit(SuccessProfileState());
      return userLayer.user;
    } catch (e) {
      emit(ErrorProfileState());
      print(e);
    }
  }

  getAllUserOrders() async {
    emit(LoadingProfileState());
    try {
      userOrders.orders = await DataRepository()
          .getAllOrdersByUser(userID: userLayer.user.userId);
    } catch (e) {
      print(e);
    }
  }
}
