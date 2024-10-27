import '../../integrations/supabase/supabase_client.dart';

mixin AddressRepository {
  // Supabase client instance
  // final SupabaseClient _supabase = SupabaseService().client;

  /*
  *
  * Tested
  * Add new Address
  *
  * */
   Future<List<Map<String, dynamic>>> addNewAddress(
      {required String city, required String userID}) async {
    try {
      final dataFound = await KanSupabase.supabase.client.from("address").insert({
        "city": city,
        "user_id": userID
      }).select(); // here we need to check if i can to deplicated or not
      return dataFound;
    } catch (e) {
      throw Exception('Error in add address: $e');
    }
  }

  /*
  *
  * Tested
  * Update Address
  *
  * */

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

  /*
  *
  * Tested
  * Delete address
  *
  * */

  deleteAddress({required String id}) async {
    try {
      final dataFound = await KanSupabase.supabase.client
          .from("orders")
          .select("*")
          .eq("address_id", id)
          .select();

      if (dataFound.isNotEmpty) {
      } else {
        await KanSupabase.supabase.client
            .from("address")
            .delete()
            .eq("address_id", id)
            .select();
      }
    } catch (e) {
      throw Exception('Error in delete address: $e');
    }
  }

  /*
  *
  * Tested
  * get all Address
  *
  * */
  Future<List<Map<String, dynamic>>> getAllAddress() async {
    try {
      final response = await KanSupabase.supabase.client.from("address").select("*");
      return response;
    } catch (e) {
      throw Exception('Error in get all address: $e');
    }
  }
}
