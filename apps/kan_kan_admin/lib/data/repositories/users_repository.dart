import 'package:kan_kan_admin/model/models_2/user_model.dart';

import '../../integrations/supabase/supabase_client.dart';

class UsersRepository {
  static Future<List<UserModel>> getAllUsers() async {
    try {
      final response =
          await KanSupabase.supabase.client.from("users").select("*");
      return response.map((element) => UserModel.fromJson(element)).toList();
    } catch (e) {
      throw Exception('Error in get all users: $e');
    }
  }
}
