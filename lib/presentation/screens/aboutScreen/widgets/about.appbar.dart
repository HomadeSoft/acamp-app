import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:flutter/material.dart';

AppBar aboutAppBar({required bool themeFlag}) {
  return AppBar(
    elevation: 0,
    automaticallyImplyLeading: false,
    backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          Strings.aboutText,
          style: TextStyle(
            color: themeFlag ? AppColors.creamColor : AppColors.mirage,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
