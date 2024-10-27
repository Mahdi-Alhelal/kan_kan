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

  static Future<List<UserModel>> updateUserRole(
      {required String userID, required String role}) async {
    try {
      final response = await KanSupabase.supabase.client
          .from("users")
          .update({"role": role}).eq("user_id", userID);
      return response.map((element) => UserModel.fromJson(element)).toList();
    } catch (e) {
      throw Exception('Error in update user role: $e');
    }
  }
}
