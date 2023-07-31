// ignore_for_file: use_build_context_synchronously

import 'package:campings_app/app/constants/app.assets.dart';
import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/app/constants/app.values.dart';
import 'package:campings_app/app/routes/app.routes.dart';
import 'package:campings_app/core/models/camping.model.dart';
import 'package:campings_app/core/notifiers/authentication.notifier.dart';
import 'package:campings_app/core/notifiers/camping.notifier.dart';
import 'package:campings_app/core/notifiers/favourite.notifier.dart';
import 'package:campings_app/core/notifiers/theme.notifier.dart';
import 'package:campings_app/core/service/maps.service.dart';
import 'package:campings_app/presentation/screens/campingScreen/camping.screen.dart';
import 'package:campings_app/presentation/screens/homeScreen/widgets/camping.maps.widget.dart';
import 'package:campings_app/presentation/screens/homeScreen/widgets/feature.widget.dart';
import 'package:campings_app/presentation/widgets/custom.snackbar.dart';
import 'package:campings_app/presentation/widgets/shimmer.effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier =
        Provider.of<ThemeNotifier>(context, listen: true);
    var themeFlag = themeNotifier.darkTheme;
    Provider.of<MapsService>(context, listen: false).getCurrentLocation();
    AuthenticationNotifer auth =
        Provider.of<AuthenticationNotifer>(context, listen: true);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: themeFlag ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: 230,
                            height: 35,
                            child: Image.asset(
                              AppAssets.appNameLogoTitle,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child: Text(
                        //     "${Strings.greetings} ${auth.userName ?? Strings.genericUser}",
                        //     style: TextStyle(
                        //       color: themeFlag
                        //           ? AppColors.creamColor
                        //           : AppColors.mirage,
                        //       fontSize: 22,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),

                    // Text(
                    //   Strings.find,
                    //   style: TextStyle(
                    //     color: themeFlag
                    //         ? AppColors.creamColor
                    //         : AppColors.mirage,
                    //     fontSize: 14,
                    //   ),
                    // ),
                    // Text(
                    //   Strings.findBest,
                    //   style: TextStyle(
                    //     color: themeFlag
                    //         ? AppColors.creamColor
                    //         : AppColors.mirage,
                    //     fontWeight: FontWeight.w600,
                    //     fontSize: 22,
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.featured,
                          style: TextStyle(
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRouter.allCampingsRoute,
                            );
                          },
                          child: const Text(
                            Strings.seeAll,
                            style: TextStyle(
                              // height: 3,
                              color: AppColors.yellowish,
                              // fontWeight: FontWeight.w500,
                              // decoration: TextDecoration.underline,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 3,
                // height: totalHeight * 280,
                child: Consumer<CampingNotifier>(
                  builder: (context, notifier, _) {
                    return FutureBuilder(
                      future: notifier.getNearbyCampings(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            !snapshot.hasData) {
                          return ShimmerEffects.loadShimmerHome(
                            context: context,
                          );
                        } else {
                          List campingsList = snapshot.data as List;
                          if (campingsList.isNotEmpty) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: campingsList.length > 4
                                  ? 4
                                  : campingsList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                CampingModel campingModel = campingsList[index];
                                return FeatureCampings(
                                  campingModel: campingModel,
                                  onTapFavorite: () async {
                                    var data = Provider.of<FavouriteNotifier>(
                                        context,
                                        listen: false);
                                    bool isAdded = await data.addToFavourite(
                                      userId: auth.userId!,
                                      campingId: campingModel.campingId,
                                    );
                                    if (isAdded) {
                                      SnackUtil.showSnackBar(
                                        context: context,
                                        text: Strings.addingFavouriteSuccess,
                                        textColor: AppColors.creamColor,
                                        backgroundColor: Colors.red.shade200,
                                      );
                                    } else {
                                      SnackUtil.showSnackBar(
                                        context: context,
                                        text: data.error!,
                                        textColor: AppColors.creamColor,
                                        backgroundColor: Colors.red.shade200,
                                      );
                                    }
                                  },
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRouter.campingDetailRoute,
                                      arguments: CampingScreenArgs(
                                          campingId: campingModel.campingId),
                                    );
                                  },
                                );
                              },
                            );
                          } else {
                            return ListView();
                          }
                        }
                      },
                    );
                  },
                ),
              ),
              Flexible(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryGreen),
                        borderRadius: BorderRadius.circular(Values.corners)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Values.corners),
                      child: const CampingsMap(),
                    ),
                  ),
                ),
              )
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Event's",
              //         style: TextStyle(
              //           color: themeFlag
              //               ? AppColors.creamColor
              //               : AppColors.mirage,
              //           fontWeight: FontWeight.w500,
              //           fontSize: 22,
              //         ),
              //       ),
              //       Text(
              //         "Happening, Near By Hotel's",
              //         style: TextStyle(
              //           color: themeFlag
              //               ? AppColors.creamColor
              //               : AppColors.mirage,
              //           fontWeight: FontWeight.w500,
              //           fontSize: 14,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: totalHeight * 200,
              //   child: Consumer<EventsNotifier>(
              //     builder: (context, notifier, _) {
              //       return FutureBuilder(
              //         future: notifier.getAllEvents(),
              //         builder:
              //             (BuildContext context, AsyncSnapshot snapshot) {
              //           if (snapshot.connectionState ==
              //                   ConnectionState.waiting ||
              //               !snapshot.hasData) {
              //             return ShimmerEffects.loadShimmerEvent(
              //               context: context,
              //             );
              //           } else {
              //             List eventsList = snapshot.data as List;
              //             if (eventsList.isEmpty) {
              //               return noDataFound(themeFlag: themeFlag);
              //             }
              //             return ListView.builder(
              //               shrinkWrap: true,
              //               itemCount: snapshot.data.length,
              //               scrollDirection: Axis.horizontal,
              //               itemBuilder: (context, index) {
              //                 EventsModel eventsModel = eventsList[index];
              //                 return EventsItem(
              //                   eventsModel: eventsModel,
              //                   onTap: () {},
              //                 );
              //               },
              //             );
              //           }
              //         },
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
