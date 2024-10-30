import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan/data/data_repository.dart';
import 'package:kan_kan/layer/address_layer.dart';
import 'package:meta/meta.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());
  final addressLayer = GetIt.I.get<AddressLayer>();
  int address = 1;

  fetchAddressEvent({required String userID}) async {
    Future.delayed(Duration.zero);
    if (!isClosed) emit(LoadingAddressState());
    try {
      addressLayer.addressUserList =
          await DataRepository().getAllAddressByUser(userID: userID);
      print(addressLayer.addressUserList.first.toString());
      if (!isClosed) emit(SuccessAddressState());
    } catch (e) {
      if (!isClosed) emit(ErrorAddressState());
    }
  }

  updateChipEvent() {
    emit(SuccessAddressState());
  }
}
