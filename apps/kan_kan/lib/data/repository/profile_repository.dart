import 'package:kan_kan/integrations/supabase/supabase_client.dart';
import 'package:kan_kan/model/user_model.dart';

mixin ProfileRepository {
  updateProfile({required UserModel user}) async {
    try {
      final res = await KanSupabase.supabase.client
          .from("users")
          .update(user.toJsonUpdate());
    } catch (e) {}
  }
}
