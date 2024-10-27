import '../../integrations/supabase/supabase_client.dart';

class UsersRepository {
  static Future<List<Map<String, dynamic>>> getAllAddress() async {
    try {
      final response = await KanSupabase.supabase.client.from("users").select("*");
      return response;
    } catch (e) {
      throw Exception('Error in get all users: $e');
    }
  }
}
