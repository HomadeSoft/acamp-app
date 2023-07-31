import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/app/routes/app.routes.dart';
import 'package:campings_app/core/models/booking.model.dart';
import 'package:campings_app/core/notifiers/authentication.notifier.dart';
import 'package:campings_app/core/notifiers/booking.notifer.dart';
import 'package:campings_app/core/notifiers/theme.notifier.dart';
import 'package:campings_app/presentation/screens/campingScreen/camping.screen.dart';
import 'package:campings_app/presentation/screens/prevBookingScreen/widgets/booking.item.dart';
import 'package:campings_app/presentation/widgets/no.data.dart';
import 'package:campings_app/presentation/widgets/shimmer.effects.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreviousBookingScreen extends StatelessWidget {
  const PreviousBookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier =
        Provider.of<ThemeNotifier>(context, listen: true);
    AuthenticationNotifer auth =
        Provider.of<AuthenticationNotifer>(context, listen: false);
    var themeFlag = themeNotifier.darkTheme;
    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Text(
                    Strings.bookingsTitle,
                    style: TextStyle(
                      color:
                          themeFlag ? AppColors.creamColor : AppColors.mirage,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Text(
                    Strings.previousBookings,
                    style: TextStyle(
                      color:
                          themeFlag ? AppColors.creamColor : AppColors.mirage,
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                  ),
                ),
                Consumer<BookingNotifier>(
                  builder: (context, notifier, _) {
                    return FutureBuilder(
                      future: notifier.getSpecificCamping(userId: auth.userId!),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ShimmerEffects.loadBookingItem(
                              context: context);
                        } else {
                          if (!snapshot.hasData) {
                            return noDataFound(
                              themeFlag: themeFlag,
                            );
                          } else {
                            List bookingData = snapshot.data as List;
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                BookingModel bookingModel = bookingData[index];
                                return BookingItem(
                                  bookingModel: bookingModel,
                                  themeFlag: themeFlag,
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRouter.campingDetailRoute,
                                      arguments: CampingScreenArgs(
                                        campingId:
                                            bookingModel.campings!.campingId,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
