import 'package:kan_kan_admin/model/user_model.dart';

class UserLayer {
  List<UserModel> usersList = [];

  UserModel getOrderUser({required String id}) {
    return usersList.firstWhere(
      (element) => element.userId == id,
      orElse: () => UserModel(
        userId: id,
        fullName: 'Unknown User',
        email: '',
        phone: '',
        profileUrl: '',
        balance: 0.0,
        userStatus: 'blocked',
        role: 'user',
      ),
    );
  }
}
