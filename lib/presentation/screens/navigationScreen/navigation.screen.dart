import 'package:campings_app/core/notifiers/theme.notifier.dart';
import 'package:campings_app/presentation/screens/favouriteScreen/favourite.screen.dart';
import 'package:campings_app/presentation/screens/homeScreen/home.screen.dart';
import 'package:campings_app/presentation/screens/navigationScreen/widgets/nav.bottomNav.dart';
import 'package:campings_app/presentation/screens/searchScreen/search.screen.dart';
import 'package:campings_app/presentation/screens/settingScreen/setting.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int pageIndex = 0;
  final PageController homePageController = PageController();

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = themeNotifier.darkTheme;
    return Scaffold(
      body: PageView(
        controller: homePageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (page) {
          setState(() {
            pageIndex = page;
          });
        },
        children: const [
          HomeScreen(),
          SearchScreen(),
          FavouriteScreen(),
          SettingScreen()
        ],
      ),
      bottomNavigationBar: BottomNav(
        controller: homePageController,
        index: pageIndex,
        themeFlag: themeFlag,
      ),
    );
  }
}
