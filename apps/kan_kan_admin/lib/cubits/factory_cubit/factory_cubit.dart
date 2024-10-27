import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/data/data_repository.dart';
import 'package:kan_kan_admin/layer/factory_data_layer.dart';
import 'package:kan_kan_admin/model/factory_model.dart';
import 'package:meta/meta.dart';

part 'factory_state.dart';

class FactoryCubit extends Cubit<FactoryState> {
  final factoryLayer = GetIt.I.get<FactoryDataLayer>();
  final api = DataRepository();

  //?--controllers
  TextEditingController factoryNameController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController repController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  FactoryCubit() : super(FactoryInitial());

  void addFactoryEvent() async {
    await Future.delayed(Duration.zero);
    FactoryModel factory = FactoryModel(
        region: regionController.text,
        department: departmentController.text,
        factoryId: 0,
        isBlackList: false,
        factoryName: factoryNameController.text,
        contactPhone: phoneNumberController.text,
        factoryRepresentative: repController.text);
    try {
      await api.addNewFactory(factory: factory);
    } catch (errorMessage) {
      log(errorMessage.toString());
      emit(ErrorState(errorMessage: errorMessage.toString()));
    }

    emit(SuccessState());
  }
}
