import 'package:kan_kan_admin/model/user_model.dart';

import '../../integrations/supabase/supabase_client.dart';

mixin UsersRepository {
  Future<List<UserModel>> getAllUsers() async {
    try {
      final response =
          await KanSupabase.supabase.client.from("users").select("*");
      return response.map((element) => UserModel.fromJson(element)).toList();
    } catch (e) {
      throw Exception('Error in get all users: $e');
    }
  }

  Future<List<UserModel>> updateUserRole(
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

  updateUserStatus({required String userId, required String userStatus}) async {
    try {
      await KanSupabase.supabase.client
          .from("users")
          .update({"user_status": userStatus}).eq("user_id", userId);
      return true;
    } catch (e) {
      throw Exception('Error in update user status: $e');
    }
  }

  updateUserProfile(
      {required String userID,
      required String status,
      required String phone,
      required double balance,
      required String fullName}) async {
    try {
      await KanSupabase.supabase.client.from("users").update({
        "user_status": status,
        "phone": phone,
        "full_name": fullName,
        "balance": balance,
        "role": "user"
      }).eq("user_id", userID);
      return true;
    } catch (e) {
      throw Exception('Error in update user role: $e');
    }
  }
}
