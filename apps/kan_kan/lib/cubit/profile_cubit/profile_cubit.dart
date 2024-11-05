import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan/data/data_repository.dart';
import 'package:kan_kan/data/repository/deal_repository.dart';
import 'package:kan_kan/layer/deal_data_layer.dart';
import 'package:kan_kan/layer/order_data_layer.dart';
import 'package:kan_kan/layer/user_data_layer.dart';
import 'package:kan_kan/model/order_model.dart';
import 'package:kan_kan/model/user_model.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()) {
    call();
  }

  call() async {
    await getAllUserOrders();
  }

  

  final userLayer = GetIt.I.get<UserDataLayer>();
  final userOrders = GetIt.I.get<OrderDataLayer>();
  final userDeals = GetIt.I.get<DealDataLayer>();

  List<OrderModel> listOrdersNow = [];
  List<OrderModel> listPreviosOrders = [];

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
      emit(SuccessUpdateProfileState());
      return userLayer.user;
    } catch (e) {
      emit(ErrorProfileState());
      print(e);
      print("ssss");
    }
  }

  getAllUserOrders() async {
    emit(LoadingProfileState());
    try {
      userOrders.orders = await DataRepository()
          .getAllOrdersByUser(userID: userLayer.user.userId);
      listOrdersNow = userOrders.orders
          .where(
            (element) =>
                element.orderStatus != "completed" &&
                element.orderStatus != "canceled",
          )
          .toList();

      listPreviosOrders = userOrders.orders
          .where(
            (element) =>
                element.orderStatus == "completed" ||
                element.orderStatus == "canceled",
          )
          .toList();
      emit(SuccessProfileState());
    } catch (e) {
      print(e);
    }
  }

  cancelOrderByUser({required int index}) {
    listPreviosOrders.add(listOrdersNow[index]);
    listOrdersNow.removeAt(index);

    emit(SuccessProfileState());
  }
}
