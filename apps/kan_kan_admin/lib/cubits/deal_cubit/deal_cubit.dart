import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/layer/deal_data_layer.dart';
import 'package:meta/meta.dart';

part 'deal_state.dart';

class DealCubit extends Cubit<DealState> {
  final dealLayer = GetIt.I.get<DealDataLayer>();

  DealCubit() : super(DealInitial());
}
