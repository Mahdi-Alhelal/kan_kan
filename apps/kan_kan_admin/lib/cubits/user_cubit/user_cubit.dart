import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/data/repositories/users_repository.dart';
import 'package:kan_kan_admin/layer/user_layer.dart';
import 'package:kan_kan_admin/model/user_model.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final userLayer = GetIt.I.get<UserLayer>();

  UserCubit() : super(UserInitial());
}
