import 'package:campings_app/app/constants/app.assets.dart';
import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/core/notifiers/theme.notifier.dart';
import 'package:campings_app/presentation/screens/aboutScreen/widgets/about.appbar.dart';
import 'package:campings_app/presentation/widgets/custom.styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier =
        Provider.of<ThemeNotifier>(context, listen: true);
    var themeFlag = themeNotifier.darkTheme;
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: aboutAppBar(
        themeFlag: themeFlag,
      ),
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      body: Column(
        children: [
          SizedBox(
            height: mediaQueryHeight / 8,
          ),
          Center(
            child: Image.asset(
              AppAssets.logo,
              height: 140,
              width: 140,
            ),
          ),
          SizedBox(
            height: mediaQueryHeight / 20,
          ),
          Text(
            Strings.appName,
            textAlign: TextAlign.left,
            style: kBodyText.copyWith(
              fontSize: 25,
              color: themeFlag ? AppColors.creamColor : AppColors.mirage,
            ),
          ),
          SizedBox(
            height: mediaQueryHeight / 50,
          ),
          Text(
            Strings.packageName,
            textAlign: TextAlign.left,
            style: kBodyText.copyWith(
              fontSize: 16,
              color: themeFlag ? AppColors.creamColor : AppColors.mirage,
            ),
          ),
          Text(
            Strings.buildNumber,
            textAlign: TextAlign.left,
            style: kBodyText.copyWith(
              fontSize: 16,
              color: themeFlag ? AppColors.creamColor : AppColors.mirage,
            ),
          ),
          Text(
            Strings.appVersion,
            textAlign: TextAlign.left,
            style: kBodyText.copyWith(
              fontSize: 16,
              color: themeFlag ? AppColors.creamColor : AppColors.mirage,
            ),
          ),
          SizedBox(
            height: mediaQueryHeight / 40,
          ),
          Text(
            Strings.contactMessage,
            textAlign: TextAlign.center,
            style: kBodyText.copyWith(
              fontSize: 16,
              color: themeFlag ? AppColors.creamColor : AppColors.mirage,
            ),
          )
        ],
      ),
    );
  }
}
