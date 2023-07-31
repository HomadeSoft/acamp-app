import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/core/models/camping.model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../../../app/constants/app.strings.dart';

class CampingFooter extends StatelessWidget {
  final CampingModel campingModel;

  const CampingFooter({
    Key? key,
    required this.campingModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Spacer(flex: 1),
        Expanded(
          flex: 3,
          child: GestureDetector(
            onTap: () async {
              final availableMaps = await MapLauncher.installedMaps;
              await availableMaps.first.showMarker(
                  coords:
                      Coords(campingModel.campingLat, campingModel.campingLong),
                  title: campingModel.campingName);
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map_outlined,
                    color: AppColors.yellowish,
                    size: 18,
                  ),
                  Text(
                    Strings.map,
                    style: TextStyle(color: AppColors.yellowish, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(flex: 2),
        Expanded(
          flex: 3,
          child: GestureDetector(
            onTap: () {
              final Uri url = Uri.parse('tel://${campingModel.campingCallNo}');
              launchUrl(url);
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone,
                    color: AppColors.yellowish,
                    size: 18,
                  ),
                  Text(
                    Strings.call,
                    style: TextStyle(color: AppColors.yellowish, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(flex: 1),
        // const Spacer(),
        // Expanded(
        //   flex: 15,
        //   child: ElevatedButton(
        //     onPressed: () async {
        //       Navigator.of(context).pushNamed(
        //         AppRouter.bookingRoute,
        //         arguments: BookingScreenArgs(
        //           userId: userId,
        //           campingData: campingModel,
        //         ),
        //       );
        //     },
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: AppColors.yellowish,
        //     ),
        //     child: const Text(
        //       "Book Now",
        //       style: TextStyle(
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
