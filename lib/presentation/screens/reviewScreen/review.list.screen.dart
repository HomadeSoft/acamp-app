import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/app/constants/app.values.dart';
import 'package:campings_app/core/models/review.model.dart';
import 'package:campings_app/core/notifiers/review.notifier.dart';
import 'package:campings_app/core/notifiers/theme.notifier.dart';
import 'package:campings_app/presentation/widgets/no.data.dart';
import 'package:campings_app/presentation/widgets/shimmer.effects.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ReviewListScreen extends StatelessWidget {
  final int campingId;

  const ReviewListScreen({Key? key, required this.campingId}) : super(key: key);

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
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 40),
                child: Text(
                  Strings.allReviews,
                  style: TextStyle(
                    color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
              SizedBox(
                height: totalHeight * 670,
                child: Consumer<ReviewNotifier>(
                  builder: (context, notifier, _) {
                    return FutureBuilder(
                      future:
                          notifier.getReviewsForCamping(campingId: campingId),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ShimmerEffects.loadShimmerFavouriteandSearch(
                            context: context,
                            displayTrash: false,
                          );
                        } else {
                          List reviews = snapshot.data as List;
                          if (reviews.isEmpty) {
                            return noDataFound(
                              themeFlag: themeFlag,
                            );
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: reviews.length,
                              itemBuilder: (context, index) {
                                ReviewModel review = reviews[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 15),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(Values.corners),
                                    ),
                                    color: themeFlag
                                        ? AppColors.creamColor
                                        : AppColors.mirage,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Values.corners)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.star,
                                                            size: 18,
                                                            color: Colors.amber,
                                                          ),
                                                          Text(
                                                            review.reviewStars
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: themeFlag
                                                                  ? AppColors
                                                                      .mirage
                                                                  : AppColors
                                                                      .creamColor,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12),
                                                            child: Text(
                                                              review.reviewTitle
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: themeFlag
                                                                    ? AppColors
                                                                        .mirage
                                                                    : AppColors
                                                                        .creamColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        review.createdAt,
                                                        style: const TextStyle(
                                                            color: AppColors
                                                                .yellowish,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text(
                                                      review.reviewDescription,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: themeFlag
                                                            ? AppColors.mirage
                                                            : AppColors
                                                                .creamColor,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            // Here
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
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
