import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/layer/factory_data_layer.dart';
import 'package:meta/meta.dart';

part 'factory_state.dart';

class FactoryCubit extends Cubit<FactoryState> {
  final factoryLayer = GetIt.I.get<FactoryDataLayer>();

  //?--controllers
  TextEditingController factoryNameController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController repController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  FactoryCubit() : super(FactoryInitial());
}
