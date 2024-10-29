import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan/data/data_repository.dart';
import 'package:kan_kan/layer/deal_data_layer.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    call();
  }
  final dealLayer = GetIt.I.get<DealDataLayer>();

  call() async {
    await getAllDeals();
  }

  getAllDeals() async {
    emit(LoadingHomeState());

    try {
      dealLayer.deals = await DataRepository().getAllDeals();
      emit(SuccessHomeState());
      print(dealLayer.deals.first.dealId);
    } catch (e) {
      print(e);
    }
  }
}
