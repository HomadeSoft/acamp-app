import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:flutter/material.dart';

class LoadingDialog {
  static showLoaderDialog(
      {required BuildContext context, required bool themeFlag}) {
    AlertDialog alert = AlertDialog(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      content: Row(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            width: 5,
          ),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: Text(
              Strings.loading,
              style: TextStyle(
                color: themeFlag ? AppColors.creamColor : AppColors.mirage,
              ),
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
