import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class KanSupabase {
  static late Supabase supabase;

  static Future<void> connect() async{
    final supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
    final supabaseKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';
    supabase =await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
    print("connect");
  }
}
