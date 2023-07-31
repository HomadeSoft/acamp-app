import 'package:cached_network_image/cached_network_image.dart';
import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/app/constants/app.values.dart';
import 'package:campings_app/core/models/camping.model.dart';
import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({Key? key, this.onTap, required this.campingModel})
      : super(key: key);

  final GestureTapCallback? onTap;
  final CampingModel campingModel;

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height / 815;
    double totalWidth = MediaQuery.of(context).size.width / 375;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: totalHeight * 205,
        width: totalWidth * 375,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Values.corners),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: campingModel.campingPhotos[0],
                imageBuilder: (context, imageProvider) => Container(
                  height: totalHeight * 205,
                  width: totalWidth * 375,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Container(
                height: totalHeight * 205,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: const [0.0, 0.9],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.9),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      campingModel.campingName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: totalHeight * 14,
                      ),
                    ),
                    Text(
                      campingModel.campingType,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: totalHeight * 12,
                      ),
                    ),
                    Text(
                      campingModel.campingAddress,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: totalHeight * 12,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: AppColors.yellowish,
                          size: totalHeight * 12,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          campingModel.campingRating.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: totalHeight * 12,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '\$ ${campingModel.campingPrice.toString()} ${Strings.perNight}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.yellowish,
                        fontSize: totalHeight * 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
