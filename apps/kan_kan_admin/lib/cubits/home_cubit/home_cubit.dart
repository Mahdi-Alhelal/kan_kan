import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/layer/deal_data_layer.dart';
import 'package:kan_kan_admin/layer/factory_data_layer.dart';
import 'package:kan_kan_admin/layer/product_data_layer.dart';
import 'package:kan_kan_admin/layer/user_layer.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  int touchedIndex = -1;
  final dealLayer = GetIt.I.get<DealDataLayer>();
  final productLayer = GetIt.I.get<ProductDataLayer>();
  final factoryLayer = GetIt.I.get<FactoryDataLayer>();
  final userLayer = GetIt.I.get<UserLayer>();

  HomeCubit() : super(HomeInitial());

  update() {
    emit(UpdateState());
  }
}
