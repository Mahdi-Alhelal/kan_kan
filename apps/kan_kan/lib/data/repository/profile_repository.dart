import 'package:kan_kan/integrations/supabase/supabase_client.dart';
import 'package:kan_kan/model/user_model.dart';

mixin ProfileRepository {
  Future<UserModel> updateProfile({required UserModel user}) async {
    try {
      final res = await KanSupabase.supabase.client
          .from("users")
          .update(user.toJsonUpdate())
          .eq("user_id", user.userId)
          .select();
      return UserModel.fromJson(res.first);
    } catch (e) {
      throw ("Error $e");
    }
  }

}