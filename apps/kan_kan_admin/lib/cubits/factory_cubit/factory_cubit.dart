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

  //?-- table sorting
  bool sort = true;
  int columnIndex = 0;

//?-- temporary  Status
  bool tmpStatus= false;

//?-- cubit function
  FactoryCubit() : super(FactoryInitial());

  void addFactoryEvent() async {
    await Future.delayed(Duration.zero);
    FactoryModel factory = FactoryModel(
      region: regionController.text.trim(),
      department: departmentController.text.trim(),
      factoryId: 0,
      isBlackList: false,
      factoryName: factoryNameController.text.trim(),
      contactPhone: phoneNumberController.text.trim(),
      factoryRepresentative: repController.text.trim(),
    );
    try {
      await api.addNewFactory(factory: factory);
      emit(SuccessState());
    } catch (errorMessage) {
      emit(ErrorState(errorMessage: errorMessage.toString()));
    }
  }

  updateFactoryEvent({required int factoryId}) async {
    try {
      await api.updateFactory(
        factory: FactoryModel(
          region: regionController.text.trim(),
          department: departmentController.text.trim(),
          factoryId: factoryId,
          isBlackList: false,
          factoryName: factoryNameController.text.trim(),
          contactPhone: phoneNumberController.text.trim(),
          factoryRepresentative: repController.text.trim(),
        ),
      );
    } catch (errorMessage) {
      emit(ErrorState(errorMessage: errorMessage.toString()));
    }
  }

  sortEvent() {
    emit(SuccessState());
  }

  updateFactoryStatusEvent({required int id}) async {
    await Future.delayed(Duration.zero);
    try {
      await api.updateFactoryStatus(status: tmpStatus, id: id);
      emit(SuccessState());
    } catch (errorMessage) {
      print(errorMessage);
      
      emit(ErrorState(errorMessage: errorMessage.toString()));
    }
  }
}
