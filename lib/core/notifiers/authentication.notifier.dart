import 'package:campings_app/app/constants/app.keys.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/core/api/supabase.api.dart';
import 'package:campings_app/core/models/user.model.dart';
import 'package:campings_app/core/service/authentication.service.dart';
import 'package:campings_app/core/service/cache.service.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationNotifer extends ChangeNotifier {
  final AuthenticationService _authenticationService = AuthenticationService();
  String? error;
  int? userId;
  String? userName;
  String? userPhoto;
  String? userEmail;
  String? userPhoneNo;

  Future<bool> signUp({
    required UserModel userModel,
  }) async {
    try {
      AuthResponse response = await _authenticationService.signUp(
        email: userModel.userEmail,
        password: userModel.userPassword,
      );

      if (response.user != null) {
        notifyListeners();
        try {
          var dataAdded = await addUserToDatabase(userModel: userModel);
          userId = dataAdded!.userId;
          // getUserDataByID(user_id: userId!);
          setUserData(user: dataAdded);
          CacheService.setInt(
            key: AppKeys.userData,
            value: userId!,
          );
          return true;
        } on PostgrestException catch (e) {
          error = e.message;
          notifyListeners();
          return false;
        }
      } else {
        error = Strings.errorCreatingUser;
        notifyListeners();
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      AuthResponse response =
          await _authenticationService.login(email: email, password: password);
      if (response.session != null) {
        notifyListeners();
        var userData = await getUserDataByEmail(useremail: email);
        userId = userData!.userId;
        setUserData(user: userData);
        // userId = userData!.data['user_id'];
        // getUserDataByID(user_id: userId!);

        CacheService.setInt(
          key: AppKeys.userData,
          value: userId!,
        );
        return true;
      } else {
        error = Strings.errorLogin;
        notifyListeners();
        return false;
      }
    } on PostgrestException catch (e) {
      error = e.message;
      return false;
    } on AuthException catch (e) {
      if (e.statusCode!.contains("400")) {
        error = Strings.confirmEmail;
      }
      return false;
    } catch (e) {
      error = e.toString();
      return false;
    }
  }

  Future<UserModel?> addUserToDatabase({required UserModel userModel}) async {
    try {
      var response = await SupabaseAPI.supabaseClient
          .from("users")
          .insert({
            "created_at": userModel.createdAt.toString(),
            "user_name": userModel.userName.toString(),
            "user_email": userModel.userEmail.toString(),
            "user_password": userModel.userPassword.toString(),
            "user_phone_no": userModel.userPhoneNo,
          })
          .select()
          .single();
      return UserModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  Future<UserModel?> getUserDataByEmail({required String useremail}) async {
    try {
      var response = await SupabaseAPI.supabaseClient
          .from("users")
          .select()
          .eq("user_email", useremail)
          .single();
      if (kDebugMode) {
        print(response.toString());
      }
      return UserModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  void setUserData({required UserModel user}) {
    userId = user.userId;
    userEmail = user.userEmail;
    userPhoto = user.userProfileUrl;
    userName = user.userName;
    userPhoneNo = user.userPhoneNo;
    notifyListeners();
  }

  Future getUserDataByID({required int userId}) async {
    try {
      var response = await SupabaseAPI.supabaseClient
          .from("users")
          .select()
          .eq("user_id", userId)
          .single();

      var user = UserModel.fromJson(response);
      setUserData(user: user);
    } on PostgrestException catch (e) {
      await CacheService.deleteKey(key: AppKeys.userData);
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  Future<bool> updateUserData({
    required String useremail,
    required String username,
    required String userMobileNo,
    required String userPhoto,
  }) async {
    try {
      UserModel updatedUser = await _authenticationService.updateUserData(
        useremail: useremail,
        username: username,
        userMobileNo: userMobileNo,
        userPhoto: userPhoto,
      );

      // print(isUpdated.data);
      setUserData(user: updatedUser);
      // getUserDataByID(user_id: userId!);
      return true;
    } on PostgrestException catch (e) {
      error = e.message;
      return false;
    }
  }
}
