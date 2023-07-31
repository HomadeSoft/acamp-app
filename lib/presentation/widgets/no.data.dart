import 'package:campings_app/app/constants/app.assets.dart';
import 'package:flutter/material.dart';

Widget noDataFound({required bool themeFlag}) {
  return Center(
    child: Image.asset(
      themeFlag ? AppAssets.noDataLight : AppAssets.noDataDark,
    ),
  );
}
