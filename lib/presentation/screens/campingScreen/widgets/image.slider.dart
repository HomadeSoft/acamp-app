import 'package:cached_network_image/cached_network_image.dart';
import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/core/models/camping.model.dart';
import 'package:campings_app/core/notifiers/authentication.notifier.dart';
import 'package:campings_app/core/notifiers/favourite.notifier.dart';
import 'package:campings_app/presentation/widgets/custom.snackbar.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

Widget imageSlider(
    {required CampingModel campingModel, required BuildContext context}) {
  AuthenticationNotifer auth =
      Provider.of<AuthenticationNotifer>(context, listen: true);
  return SizedBox(
    height: MediaQuery.of(context).size.width - 50,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Swiper(
          itemCount: campingModel.campingPhotos.length,
          pagination: const SwiperPagination(
            builder: SwiperPagination.dots,
          ),
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return CachedNetworkImage(
              imageUrl: campingModel.campingPhotos[index],
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            );
          },
        ),
        Positioned(
          right: 10,
          bottom: -20,
          child: InkWell(
            onTap: () async {
              var data = Provider.of<FavouriteNotifier>(context, listen: false);
              bool isAdded = await data.addToFavourite(
                userId: auth.userId!,
                campingId: campingModel.campingId,
              );
              if (isAdded && context.mounted) {
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
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.favorite,
                color: AppColors.yellowish,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
