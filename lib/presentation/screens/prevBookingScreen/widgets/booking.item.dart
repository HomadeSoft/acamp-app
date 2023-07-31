import 'package:cached_network_image/cached_network_image.dart';
import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/core/models/booking.model.dart';
import 'package:flutter/material.dart';

class BookingItem extends StatelessWidget {
  final BookingModel bookingModel;
  final bool themeFlag;
  final GestureTapCallback? onTap;

  const BookingItem({
    Key? key,
    required this.bookingModel,
    this.onTap,
    required this.themeFlag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width / 375;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(27, 5, 27, 0),
        child: Card(
          color: themeFlag ? AppColors.creamColor : AppColors.mirage,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: totalWidth * 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowColor.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: CachedNetworkImage(
                        imageUrl: bookingModel.campings!.campingPhotos[1],
                        imageBuilder: (context, imageProvider) => Container(
                          height: 80,
                          width: 70,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            '${Strings.campingName} : ${bookingModel.campings!.campingName}',
                            maxLines: 1,
                            style: TextStyle(
                              color: themeFlag
                                  ? AppColors.mirage
                                  : AppColors.creamColor,
                              fontWeight: FontWeight.w500,
                              fontSize: totalWidth * 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6, top: 2),
                          child: Text(
                            '${Strings.campingAddress} : ${bookingModel.campings!.campingAddress.toString()}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: themeFlag
                                  ? AppColors.mirage
                                  : AppColors.creamColor,
                              fontSize: totalWidth * 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6, top: 2),
                          child: Text(
                            '${Strings.startDate} : ${bookingModel.bookingStartDate}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: themeFlag
                                  ? AppColors.mirage
                                  : AppColors.creamColor,
                              fontSize: totalWidth * 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6, top: 2),
                          child: Text(
                            '${Strings.campingPrice} : \$ ${bookingModel.campings!.campingPrice.toString()}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: totalWidth * 13,
                              color: AppColors.yellowish,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
