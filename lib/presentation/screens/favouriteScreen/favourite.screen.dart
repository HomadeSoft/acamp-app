import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/app/routes/app.routes.dart';
import 'package:campings_app/core/models/favourite.model.dart';
import 'package:campings_app/core/notifiers/authentication.notifier.dart';
import 'package:campings_app/core/notifiers/favourite.notifier.dart';
import 'package:campings_app/core/notifiers/theme.notifier.dart';
import 'package:campings_app/presentation/screens/campingScreen/camping.screen.dart';
import 'package:campings_app/presentation/widgets/custom.snackbar.dart';
import 'package:campings_app/presentation/widgets/no.data.dart';
import 'package:campings_app/presentation/widgets/shimmer.effects.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/favourite.item.widget.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier =
        Provider.of<ThemeNotifier>(context, listen: true);
    var themeFlag = themeNotifier.darkTheme;
    AuthenticationNotifer auth =
        Provider.of<AuthenticationNotifer>(context, listen: true);
    double totalHeight = MediaQuery.of(context).size.height / 815;
    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: Text(
                  Strings.favourite,
                  style: TextStyle(
                    color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: Text(
                  Strings.yourFavourites,
                  style: TextStyle(
                    color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                ),
              ),
              SizedBox(
                height: totalHeight * 620,
                child: Consumer<FavouriteNotifier>(
                  builder: (context, notifier, _) {
                    return FutureBuilder(
                      future: notifier.getAllFavourite(userId: auth.userId!),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ShimmerEffects.loadShimmerFavouriteandSearch(
                            context: context,
                            displayTrash: true,
                          );
                        } else {
                          if (snapshot.hasError) {
                            return noDataFound(
                              themeFlag: themeFlag,
                            );
                          } else {
                            List favoriteData = snapshot.data as List;
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                FavouriteModel favoriteModel =
                                    favoriteData[index];
                                return FavouriteItem(
                                  favoriteModel: favoriteModel,
                                  onDelete: () async {
                                    bool isDeleted =
                                        await notifier.deleteFromFavourite(
                                      favoriteId: favoriteModel.favoriteId,
                                    );
                                    if (isDeleted && context.mounted) {
                                      SnackUtil.showSnackBar(
                                        context: context,
                                        text: Strings.removedSuccessfully,
                                        textColor: AppColors.creamColor,
                                        backgroundColor: Colors.green,
                                      );
                                    } else {
                                      SnackUtil.showSnackBar(
                                        context: context,
                                        text: Strings.errorUnknown,
                                        textColor: AppColors.creamColor,
                                        backgroundColor: Colors.red.shade200,
                                      );
                                    }
                                  },
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRouter.campingDetailRoute,
                                      arguments: CampingScreenArgs(
                                        campingId:
                                            favoriteModel.campings.campingId,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
