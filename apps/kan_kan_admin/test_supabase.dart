import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';

Future<void> main() async {
  try {
    print('Loading .env file...');
    await dotenv.load(fileName: 'apps/kan_kan_admin/.env');
    
    final url = dotenv.env['SUPABASE_URL'] ?? '';
    final key = dotenv.env['SUPABASE_ANON_KEY'] ?? '';
    
    if (url.isEmpty || key.isEmpty) {
      print('Error: SUPABASE_URL or SUPABASE_ANON_KEY is empty in .env');
      exit(1);
    }

    print('Connecting to Supabase at $url...');
    await Supabase.initialize(url: url, anonKey: key);
    final supabase = Supabase.instance.client;
    
    print('Testing query on "products" table...');
    final response = await supabase
        .from('products')
        .select('product_id')
        .limit(1);
    
    print('Success! Query returned: $response');
    exit(0);
  } catch (e) {
    print('Error during connection test: $e');
    exit(1);
  }
}
