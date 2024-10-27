import 'package:kan_kan_admin/model/user_model.dart';

import '../../integrations/supabase/supabase_client.dart';

mixin UsersRepository {
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
