import 'package:kan_kan/integrations/supabase/supabase_client.dart';
import 'package:kan_kan/model/user_model.dart';

mixin ProfileRepository {
  Future logOut() async {
    try {
      KanSupabase.supabase.client.auth.signOut();
    } catch (e) {
      throw "لا يمكن تسجيل خروج رجاء تاكد من وجود انترنت";
    }
  }

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

  addCancelOrderToOrderTrack({required int orderID}) async {
    try {
      await KanSupabase.supabase.client
          .from("order_track")
          .insert({"order_id": orderID, "status": "canceled"});
    } catch (e) {
      print(e);
    }
  }
}
