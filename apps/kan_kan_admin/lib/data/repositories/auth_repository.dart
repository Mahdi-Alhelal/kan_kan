import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../integrations/supabase/supabase_client.dart';

class AuthRepository {
  //Tested
  Future loginToken({required String email}) async {
    try {
      await Future.delayed(Duration.zero);

      final data =
          await KanSupabase.supabase.client.from("users").select("*").eq("email", email);
      // GetIt.I.get<UserLayer>().user = UserModel.fromJson(data.first);
      if (kDebugMode) {
        print(data.first.toString());
      }
      return true;
    } on PostgrestException {
      throw Exception('Error inserting user data');
    } on AuthException {
      throw Exception('Error during OTP verification');
    } catch (e) {
      throw Exception('Error during OTP verification: $e');
    }
  }

//tested
  Future<void> signUp(
      {required String email,
      required String fName,
      required String phoneNumber}) async {
    try {
      var x = Random().nextInt(999999);
      // Sign up with email to send an email verification OTP
      print(x);
      final response = await KanSupabase.supabase.client.auth
          .signUp(email: email, password: "kankan1234");

      final user = response.user;
      print(user?.email);
      if (user != null) {
        await KanSupabase.supabase.client.from('users').insert({
          'user_id': user.id,
          'email': user.email,
          'full_name': fName,
          'phone': phoneNumber,
          'created_at': DateTime.now().toIso8601String(),
        });
      }
      // } on AuthException {
      //   // Handle Supabase Auth-related exceptions
      //   throw Exception('error during sign up email does not exit');
      // } on PostgrestException {
      //   // Handle Supabase PostgREST API-related exceptions
      //   throw Exception('can not connect to server');
    } catch (e) {
      // Handle any other exceptions
      throw Exception('Error during sign up: $e');
    }
  }

  Future login({required String email}) async {
    try {
      await KanSupabase.supabase.client.auth.signInWithOtp(email: email);

      return true;
    } on AuthException {
      return false;
    }
  }

//Tested
  Future verifyOtp(
      {required String email, required String otp, required int type}) async {
    try {
      await Future.delayed(Duration.zero);
      // Return the auth response if OTP verification is successful
      if (type == 0) {
        await KanSupabase.supabase.client.auth
            .verifyOTP(type: OtpType.email, email: email, token: otp);
      } else {
        await KanSupabase.supabase.client.auth
            .verifyOTP(type: OtpType.signup, email: email, token: otp);
      }
      final data =
          await KanSupabase.supabase.client.from("users").select("*").eq("email", email);
      // GetIt.I.get<UserLayer>().user = UserModel.fromJson(data.first);
      return true;
    } on PostgrestException {
      throw Exception('Error inserting user data');
    } on AuthException {
      throw Exception('Error during OTP verification');
    } catch (e) {
      throw Exception('Error during OTP verification: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await KanSupabase.supabase.client.auth.signOut();
    } catch (e) {
      throw Exception('Error during sign-out');
    }
  }
}
