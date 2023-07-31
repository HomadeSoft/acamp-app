import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/app/routes/app.routes.dart';
import 'package:campings_app/core/models/camping.model.dart';
import 'package:campings_app/core/notifiers/camping.notifier.dart';
import 'package:campings_app/core/notifiers/sorts.notifier.dart';
import 'package:campings_app/core/notifiers/theme.notifier.dart';
import 'package:campings_app/presentation/screens/allCampingsScreen/widgets/sort.menu.two.widget.dart';
import 'package:campings_app/presentation/screens/allCampingsScreen/widgets/sort.menu.widget.dart';
import 'package:campings_app/presentation/screens/campingScreen/camping.screen.dart';
import 'package:campings_app/presentation/screens/searchScreen/widgets/search.items.dart';
import 'package:campings_app/presentation/widgets/no.data.dart';
import 'package:campings_app/presentation/widgets/shimmer.effects.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCampingScreen extends StatelessWidget {
  const AllCampingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier =
        Provider.of<ThemeNotifier>(context, listen: true);
    var themeFlag = themeNotifier.darkTheme;

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
                  Strings.allCampings,
                  style: TextStyle(
                    color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.findCampingMessage,
                      style: TextStyle(
                        color:
                            themeFlag ? AppColors.creamColor : AppColors.mirage,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SortMenuTwo(),
                        SizedBox(
                          width: 10,
                        ),
                        SortMenuOne(),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: totalHeight * 670,
                child: Consumer<CampingNotifier>(
                  builder: (context, notifier, _) {
                    return FutureBuilder(
                      future: notifier.getAllCampings(
                        campingSort:
                            Provider.of<SortNotifier>(context, listen: true)
                                .campingSort,
                        sortBy: Provider.of<SortNotifier>(context, listen: true)
                            .sortBySys,
                      ),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ShimmerEffects.loadShimmerFavouriteandSearch(
                            context: context,
                            displayTrash: false,
                          );
                        } else {
                          List campingModels = snapshot.data as List;
                          if (campingModels.isEmpty) {
                            return noDataFound(
                              themeFlag: themeFlag,
                            );
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                CampingModel campingModel =
                                    campingModels[index];
                                return SearchItem(
                                  campingModel: campingModel,
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRouter.campingDetailRoute,
                                      arguments: CampingScreenArgs(
                                        campingId: campingModel.campingId,
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
