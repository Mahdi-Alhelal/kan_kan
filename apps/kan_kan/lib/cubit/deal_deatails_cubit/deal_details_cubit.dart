import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan/data/data_repository.dart';
import 'package:kan_kan/layer/deal_data_layer.dart';
import 'package:kan_kan/layer/order_data_layer.dart';
import 'package:meta/meta.dart';

part 'deal_details_state.dart';

class DealDetailsCubit extends Cubit<DealDetailsState> {
  int index = 1;
  final dealLayer = GetIt.I.get<DealDataLayer>();
  final orderLayer = GetIt.I.get<OrderDataLayer>();
  DealDetailsCubit() : super(DealDetailsInitial());
  bool enableJoin({required int dealId}) {
    late bool tmp;
    for (var element in orderLayer.orders) {
      if (element.dealId == dealId) {
        tmp = false;
        return tmp;
      }
    }
    tmp = true;
    return tmp;
  }

  increseEvent({required int maxOrderPerUser}) {
    if (index < maxOrderPerUser) index++;
    emit(SuccessIncreaseState());
  }

  decreseEvent() {
    if (index > 1) {
      index--;
      emit(SuccessIncreaseState());
    } else {
      emit(ErrorState());
    }
  }

  Future<int> checkQuantity({required int dealID}) async {
    try {
      int res = await DataRepository().getOneDealQuantity(dealID: dealID);
      return res;
    } catch (e) {
      throw (" $e خطأ");
    }
  }
}
