import 'package:campings_app/app/constants/app.strings.dart';
import 'package:flutter/material.dart';

class PasswordNotifier extends ChangeNotifier {
  String? _passwordLevel = "";
  String? get passwordLevel => _passwordLevel;

  String? _passwordEmoji = "";
  String? get passwordEmoji => _passwordEmoji;

  void checkPasswordStrength({required String password}) {
    String mediumPattern = r'^(?=.*?[!@#\$&*~]).{8,}';
    String strongPattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    if (password.contains(RegExp(strongPattern))) {
      _passwordEmoji = '🚀';
      _passwordLevel = Strings.strongPassword;
      notifyListeners();
    } else if (password.contains(RegExp(mediumPattern))) {
      _passwordEmoji = '🔥';
      _passwordLevel = Strings.mediumPassword;
      notifyListeners();
    } else if (!password.contains(RegExp(strongPattern))) {
      _passwordEmoji = '😢';
      _passwordLevel = Strings.weakPAssword;
      notifyListeners();
    }
  }
}
