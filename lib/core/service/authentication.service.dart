import 'package:campings_app/core/api/supabase.api.dart';
import 'package:campings_app/core/models/user.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationService {
  Future<AuthResponse> signUp(
      {required String email, required String password}) async {
    final AuthResponse res = await SupabaseAPI.supabaseClient.auth.signUp(
      email: email,
      password: password,
    );

    return res;
  }

  Future<AuthResponse> login(
      {required String email, required String password}) async {
    AuthResponse res = await SupabaseAPI.supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return res;
  }

  Future<UserModel> updateUserData(
      {required String useremail,
      required String username,
      required String userMobileNo,
      required String userPhoto}) async {
    var response = await SupabaseAPI.supabaseClient
        .from("users")
        .update({
          'user_name': username,
          'user_profile_url': userPhoto,
          'user_phone_no': userMobileNo
        })
        .eq("user_email", useremail)
        .select()
        .single();
    return UserModel.fromJson(response);
  }
}
