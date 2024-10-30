import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'deal_details_state.dart';

class DealDetailsCubit extends Cubit<DealDetailsState> {
  int index = 1;
  DealDetailsCubit() : super(DealDetailsInitial());

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
}
