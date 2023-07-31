// ignore_for_file: non_constant_identifier_names

import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

Widget BottomNav(
    {required int index,
    required PageController controller,
    required bool themeFlag}) {
  return Container(
    decoration: BoxDecoration(
      color: themeFlag ? AppColors.mirage : AppColors.creamColor,
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: SalomonBottomBar(
        currentIndex: index,
        onTap: (val) {
          index = val;
          controller.jumpToPage(val);
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text(Strings.home),
            unselectedColor:
                themeFlag ? AppColors.creamColor : AppColors.primaryGreen,
            selectedColor: themeFlag ? AppColors.yellowish : AppColors.mirage,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.search),
            title: const Text(Strings.search),
            unselectedColor:
                themeFlag ? AppColors.creamColor : AppColors.primaryGreen,
            selectedColor: themeFlag ? AppColors.yellowish : AppColors.mirage,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite),
            title: const Text(Strings.favourite),
            unselectedColor:
                themeFlag ? AppColors.creamColor : AppColors.primaryGreen,
            selectedColor: themeFlag ? AppColors.yellowish : AppColors.mirage,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.settings),
            title: const Text(Strings.settings),
            unselectedColor:
                themeFlag ? AppColors.creamColor : AppColors.primaryGreen,
            selectedColor: themeFlag ? AppColors.yellowish : AppColors.mirage,
          ),
        ],
      ),
    ),
  );
}
