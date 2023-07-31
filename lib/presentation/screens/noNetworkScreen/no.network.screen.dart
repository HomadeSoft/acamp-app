import 'package:campings_app/app/constants/app.assets.dart';
import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:flutter/material.dart';

class NoNetworkScreen extends StatelessWidget {
  const NoNetworkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mirage,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.wifi,
                height: 250,
                width: 250,
              ),
              const Text(
                Strings.networkIssues,
                style: TextStyle(
                  color: AppColors.creamColor,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
