import 'dart:async';
import 'package:campings_app/app/constants/app.assets.dart';
import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.keys.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/app/routes/app.routes.dart';
import 'package:campings_app/core/notifiers/authentication.notifier.dart';
import 'package:campings_app/core/notifiers/theme.notifier.dart';
import 'package:campings_app/core/service/cache.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future _initiateCache() async {
    return CacheService.conditionalCache(
      key: AppKeys.onBoardDone,
      valueType: ValueType.StringValue,
      actionIfNull: () {
        Navigator.of(context)
            .pushReplacementNamed(AppRouter.onboardingRoute)
            .whenComplete(
              () => CacheService.setString(
                  key: AppKeys.onBoardDone, value: Strings.done),
            );
      },
      actionIfNotNull: () {
        CacheService.conditionalCache(
          valueType: ValueType.IntValue,
          key: AppKeys.userData,
          actionIfNull: () {
            Navigator.of(context).pushReplacementNamed(AppRouter.loginRoute);
          },
          actionIfNotNull: () async {
            var userId = await CacheService.getInt(key: AppKeys.userData);
            if (context.mounted) {
              Provider.of<AuthenticationNotifer>(context, listen: false)
                  .getUserDataByID(userId: userId);
              Navigator.of(context).pushReplacementNamed(AppRouter.navRoute);
            }
          },
        );
      },
    );
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 1), _initiateCache);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = themeNotifier.darkTheme;
    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.appNameLogo,
              fit: BoxFit.fitWidth,
            ),
            Image.asset(
              AppAssets.appNameLogo,
              width: 50,
              fit: BoxFit.fitWidth,
            ),
            Text(
              Strings.appRegion,
              style: TextStyle(
                color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                fontSize: 50.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
