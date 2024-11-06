import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan/data/data_repository.dart';
import 'package:kan_kan/layer/user_data_layer.dart';
import 'package:meta/meta.dart';

part 'block_state.dart';

class BlockCubit extends Cubit<BlockState> {
  final userLayer = GetIt.I.get<UserDataLayer>();

  BlockCubit() : super(BlockInitial()) {
    removeToken();
  }
  removeToken() async {
    userLayer.email = "";
    await DataRepository().logOut();
  }

  logOutEvent() async {
    try {
      userLayer.email = "";
      try {
        await DataRepository().logOut();
      } catch (e) {
        return null;
      }
      emit(LogoutSuccess());
    } catch (e) {
      return null;
    }
  }
}
