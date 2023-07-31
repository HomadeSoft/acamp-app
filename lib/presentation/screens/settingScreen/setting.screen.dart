import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.keys.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/app/routes/app.routes.dart';
import 'package:campings_app/core/notifiers/authentication.notifier.dart';
import 'package:campings_app/core/notifiers/theme.notifier.dart';
import 'package:campings_app/core/service/cache.service.dart';
import 'package:campings_app/presentation/screens/profileScreen/profile.screen.dart';
import 'package:campings_app/presentation/screens/settingScreen/widgets/icon.style.dart';
import 'package:campings_app/presentation/screens/settingScreen/widgets/setting.appbar.dart';
import 'package:campings_app/presentation/screens/settingScreen/widgets/setting.user.card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/setting.item.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier =
        Provider.of<ThemeNotifier>(context, listen: true);
    var themeFlag = themeNotifier.darkTheme;
    var userData = Provider.of<AuthenticationNotifer>(context, listen: true);
    return Scaffold(
      appBar: settingAppBar(themeFlag: themeFlag),
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            UserCard(
              cardColor: AppColors.primaryGreen,
              userName: userData.userName!,
              userProfileUrl:
                  userData.userPhoto != null ? userData.userPhoto! : "",
              onTap: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            SettingsItem(
              onTap: () {
                themeNotifier.toggleTheme();
              },
              icons: Icons.dark_mode_rounded,
              iconStyle: IconStyle(
                iconsColor: AppColors.yellowish,
                withBackground: true,
                backgroundColor: themeFlag
                    ? AppColors.appDarkPrimary
                    : AppColors.appBrightPrimary,
              ),
              title: Strings.darkMode,
              subtitle: Strings.changeAppTheme,
              trailing: Switch.adaptive(
                value: themeNotifier.darkTheme,
                onChanged: (value) {
                  themeNotifier.darkTheme = !value;
                  themeNotifier.toggleTheme();
                },
                activeColor: AppColors.primaryGreen,
                trackOutlineColor:
                    MaterialStateProperty.all(AppColors.primaryGreen),
                inactiveTrackColor: AppColors.yellowish,
                inactiveThumbColor: AppColors.rawSienna,
              ),
              themeFlag: themeFlag,
            ),
            SettingsItem(
              themeFlag: themeFlag,
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRouter.profileRoute,
                  arguments: ProfileTaskArgs(
                    userName: userData.userName!,
                    userEmail: userData.userEmail!,
                    userPhoneNo: userData.userPhoneNo!,
                    userImage: userData.userPhoto ?? "",
                  ),
                );
              },
              icons: Icons.person,
              iconStyle: IconStyle(
                iconsColor: AppColors.yellowish,
                withBackground: true,
                backgroundColor: themeFlag
                    ? AppColors.appDarkPrimary
                    : AppColors.appBrightPrimary,
              ),
              title: Strings.profileTitle,
              subtitle: Strings.changeYourData,
            ),
            SettingsItem(
              themeFlag: themeFlag,
              onTap: () {
                Navigator.of(context).pushNamed(AppRouter.prevbookingRoute);
              },
              icons: Icons.bookmark,
              iconStyle: IconStyle(
                iconsColor: AppColors.yellowish,
                withBackground: true,
                backgroundColor: themeFlag
                    ? AppColors.appDarkPrimary
                    : AppColors.appBrightPrimary,
              ),
              title: Strings.bookingsTitle,
              subtitle: Strings.checkBookings,
            ),
            SettingsItem(
              onTap: () async {
                final Uri url = Uri.parse(Strings.privacyPolicyURL);
                launchUrl(url);
              },
              themeFlag: themeFlag,
              icons: Icons.fingerprint,
              iconStyle: IconStyle(
                iconsColor: AppColors.yellowish,
                withBackground: true,
                backgroundColor: themeFlag
                    ? AppColors.appDarkPrimary
                    : AppColors.appBrightPrimary,
              ),
              title: Strings.privacyTitle,
              subtitle: Strings.privacySubtitle,
            ),
            SettingsItem(
              themeFlag: themeFlag,
              onTap: () {
                Navigator.of(context).pushNamed(AppRouter.aboutRoute);
              },
              icons: Icons.info_rounded,
              iconStyle: IconStyle(
                iconsColor: AppColors.yellowish,
                withBackground: true,
                backgroundColor: themeFlag
                    ? AppColors.appDarkPrimary
                    : AppColors.appBrightPrimary,
              ),
              title: Strings.aboutTitle,
              subtitle: Strings.aboutSubtitle,
            ),
            SettingsItem(
              themeFlag: themeFlag,
              onTap: () {
                Navigator.of(context).pushNamed(AppRouter.feedbackRoute);
              },
              icons: Icons.chat_bubble,
              iconStyle: IconStyle(
                iconsColor: AppColors.yellowish,
                withBackground: true,
                backgroundColor: themeFlag
                    ? AppColors.appDarkPrimary
                    : AppColors.appBrightPrimary,
              ),
              title: Strings.feedbackTitle,
              subtitle: Strings.feedbackSubtitle,
            ),
            SettingsItem(
              themeFlag: themeFlag,
              onTap: () {
                showAlertDialog(context: context, themeFlag: themeFlag);
              },
              icons: Icons.logout,
              iconStyle: IconStyle(
                iconsColor: AppColors.yellowish,
                withBackground: true,
                backgroundColor: themeFlag
                    ? AppColors.appDarkPrimary
                    : AppColors.appBrightPrimary,
              ),
              subtitle: Strings.logoutTitle,
              title: Strings.logoutSubtitle,
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog({
    required BuildContext context,
    required bool themeFlag,
  }) {
    Widget cancelButton = TextButton(
      child: const Text(
        Strings.no,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: AppColors.yellowish,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        Strings.yes,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: AppColors.yellowish,
        ),
      ),
      onPressed: () {
        CacheService.deleteKey(key: AppKeys.userData).whenComplete(() {
          Navigator.of(context).pushReplacementNamed(AppRouter.loginRoute);
        });
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        Strings.logoutPromptQuetion,
        style: TextStyle(
          color: themeFlag ? AppColors.creamColor : AppColors.mirage,
          fontSize: 18,
        ),
      ),
      content: Text(
        Strings.logoutPromptQuetionSubText,
        style: TextStyle(
          color: themeFlag ? AppColors.creamColor : AppColors.mirage,
          fontSize: 16,
        ),
      ),
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
