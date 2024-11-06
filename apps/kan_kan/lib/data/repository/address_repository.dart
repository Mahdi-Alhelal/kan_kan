import '../../integrations/supabase/supabase_client.dart';

mixin AddressRepository {


  Future<List<Map<String, dynamic>>> addNewAddress(
      {required String city, required String userID}) async {
    try {
      final dataFound = await KanSupabase.supabase.client
          .from("address")
          .insert({
        "city": city,
        "user_id": userID
      }).select(); // here we need to check if i can to deplicated or not
      return dataFound;
    } catch (e) {
      throw Exception('Error in add address: $e');
    }
  }


  updateAddress({required String id, required String city}) async {
    try {
      final dataFound = await KanSupabase.supabase.client
          .from("address")
          .select("*")
          .match({"address_id": id}).select();
      if (dataFound.isNotEmpty) {
        await KanSupabase.supabase.client
            .from("address")
            .update({"city": city}).eq("address_id", id);
      }
    } catch (e) {
      throw Exception('Error in update address: $e');
    }
  }


  Future<List<Map<String, dynamic>>> getAllAddressByUser(
      {required String userID}) async {
    try {
      final response = await KanSupabase.supabase.client
          .from("address")
          .select("*")
          .eq("user_id", userID);
      return response;
    } catch (e) {
      throw Exception('Error in get all address: $e');
    }
  }
}
