import 'package:bloc/bloc.dart';
import 'package:kan_kan_admin/data/repositories/users_repository.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  userEvent() async {
    emit(LoadingUserState());

    try {
      final response = await UsersRepository.getAllAddress();
      print(response.toString());
    } catch (e) {
      print(e);
    }
  }
}
