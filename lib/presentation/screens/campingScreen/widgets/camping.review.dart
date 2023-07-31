import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/app/constants/app.values.dart';
import 'package:campings_app/app/routes/app.routes.dart';
import 'package:campings_app/core/models/camping.model.dart';
import 'package:campings_app/core/notifiers/authentication.notifier.dart';
import 'package:campings_app/core/notifiers/review.notifier.dart';
import 'package:campings_app/presentation/screens/reviewScreen/review.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewSummaryBox extends StatelessWidget {
  const ReviewSummaryBox({
    super.key,
    required this.themeFlag,
    required this.camping,
  });
  final bool themeFlag;
  final CampingModel camping;

  @override
  Widget build(BuildContext context) {
    AuthenticationNotifer auth =
        Provider.of<AuthenticationNotifer>(context, listen: true);
    ReviewNotifier reviewNotifier =
        Provider.of<ReviewNotifier>(context, listen: false);
    return FutureBuilder<int>(
        future: reviewNotifier.getReviewCountForCamping(
            campingId: camping.campingId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRouter.reviewListRoute,
                    arguments: camping.campingId);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Values.corners),
                ),
                color: AppColors.primaryGreen,
                // color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Values.corners)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.amber,
                              ),
                              Text(
                                camping.campingRating.toStringAsFixed(2),
                                style: const TextStyle(
                                  color: AppColors.yellowish,
                                  // color: themeFlag
                                  //     ? AppColors.mirage
                                  //     : AppColors.creamColor,
                                ),
                              )
                            ],
                          ),
                          Text(
                            "${snapshot.data != null ? snapshot.data! : 0} ${Strings.reviews}",
                            style: const TextStyle(
                              color: AppColors.yellowish,
                              // color: themeFlag
                              //     ? AppColors.mirage
                              //     : AppColors.creamColor,
                            ),
                          )
                        ],
                      ),
                      IconButton(
                        onPressed: () => {
                          Navigator.of(context).pushNamed(AppRouter.reviewRoute,
                              arguments: ReviewScreenArgs(
                                  campingId: camping.campingId,
                                  userId: auth.userId,
                                  campingRating: camping.campingRating))
                        },
                        icon: const Icon(Icons.add_circle_outline),
                        color: AppColors.yellowish,
                      )
                      // Here
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
