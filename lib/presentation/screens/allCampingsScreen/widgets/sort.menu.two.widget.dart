import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/core/notifiers/sorts.notifier.dart';
import 'package:campings_app/core/notifiers/theme.notifier.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SortMenuTwo extends StatefulWidget {
  const SortMenuTwo({Key? key}) : super(key: key);

  @override
  State<SortMenuTwo> createState() => _CustomSortMenuTwo();
}

class _CustomSortMenuTwo extends State<SortMenuTwo> {
  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier =
        Provider.of<ThemeNotifier>(context, listen: true);
    var themeFlag = themeNotifier.darkTheme;
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Icon(
          Icons.settings,
          size: 30,
          color: themeFlag ? AppColors.creamColor : AppColors.mirage,
        ),
        // customItemsIndexes: const [4],
        // customItemsHeight: 10,
        items: [
          ...MenuItems.firstItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) {
          MenuItems.onChanged(context, value as MenuItem);
        },
        menuItemStyleData: const MenuItemStyleData(
          height: 48,
          padding: EdgeInsets.only(left: 16, right: 16),
        ),
        dropdownStyleData: DropdownStyleData(
          width: 200,
          padding: const EdgeInsets.symmetric(vertical: 6),
          maxHeight: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: themeFlag ? AppColors.mirage : AppColors.creamColor,
          ),
          elevation: 8,
          offset: const Offset(0, 8),
        ),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [normal, rating, price, amenties];

  static const normal =
      MenuItem(text: Strings.sortDefault, icon: Icons.arrow_back_ios_new);
  static const rating =
      MenuItem(text: Strings.sortRating, icon: Icons.rate_review);
  static const price =
      MenuItem(text: Strings.sortPrice, icon: Icons.price_change);
  static const amenties =
      MenuItem(text: Strings.sortAmenities, icon: Icons.room_service);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: AppColors.primaryGreen, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: AppColors.primaryGreen,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.normal:
        Provider.of<SortNotifier>(context, listen: false).changeNormal();
        break;
      case MenuItems.rating:
        Provider.of<SortNotifier>(context, listen: false).changeByRating();
        break;
      case MenuItems.price:
        Provider.of<SortNotifier>(context, listen: false).changeByPrice();
        break;
      case MenuItems.amenties:
        Provider.of<SortNotifier>(context, listen: false).changeByAmentities();
        break;
    }
  }
}
