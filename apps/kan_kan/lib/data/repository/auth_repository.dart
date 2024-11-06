import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan/layer/user_data_layer.dart';
import 'package:kan_kan/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../integrations/supabase/supabase_client.dart';

mixin AuthRepository {
  String getCurrentUser() {
    return KanSupabase.supabase.client.auth.currentUser?.email ?? "";
  }

  //Tested
  int isExsit = 0;
  Future loginToken({required String email}) async {
    try {
      await Future.delayed(Duration.zero);

      final data = await KanSupabase.supabase.client
          .from("users")
          .select("*")
          .eq("email", email);
      GetIt.I.get<UserDataLayer>().user = UserModel.fromJson(data.first);

      print(data.first.toString());

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
  Future<bool> signUp({required UserModel userDetails}) async {
    try {
      await isExsitEmail(email: userDetails.email);
      if (isExsit == 0) {
        var x = Random().nextInt(999999);
        // Sign up with email to send an email verification OTP

        final response = await KanSupabase.supabase.client.auth
            .signUp(email: userDetails.email, password: "kankan$x");

        final user = response.user;
        print(user?.email);
        if (user != null) {
          userDetails.userId = user.id;

          await KanSupabase.supabase.client
              .from('users')
              .insert(userDetails.toJson());
          return true;
        }
      } else {
        throw Exception('You are already Registerd before');
      }
      return false;

      // } on AuthException {
      //   // Handle KanSupabase.supabase Auth-related exceptions
      //   throw Exception('error during sign up email does not exit');
      // } on PostgrestException {
      //   // Handle KanSupabase.supabase PostgREST API-related exceptions
      //   throw Exception('can not connect to server');
    } catch (e) {
      // Handle any other exceptions
      throw Exception('Error during sign up: $e');
    }
  }

  Future login({required String email}) async {
    try {
      await isExsitEmail(email: email);
      if (isExsit != 0) {
        await KanSupabase.supabase.client.auth.signInWithOtp(email: email);
        return true;
      } else {
        return false;
      }
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
      final data = await KanSupabase.supabase.client
          .from("users")
          .select("*")
          .eq("email", email);
      print(data.first.toString());
      return UserModel.fromJson(data.first);
    } on PostgrestException {
      throw Exception('Error inserting user data');
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

  Future isExsitEmail({required String email}) async {
    final res = await KanSupabase.supabase.client
        .from("users")
        .count()
        .eq("email", email);

    isExsit = res;
  }
}
