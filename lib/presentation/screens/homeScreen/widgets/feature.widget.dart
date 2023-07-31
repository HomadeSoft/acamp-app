import 'package:cached_network_image/cached_network_image.dart';
import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/app/constants/app.values.dart';
import 'package:campings_app/core/models/camping.model.dart';
import 'package:campings_app/presentation/widgets/no.data.dart';
import 'package:flutter/material.dart';

class FeatureCampings extends StatelessWidget {
  const FeatureCampings(
      {Key? key, this.onTap, this.onTapFavorite, required this.campingModel})
      : super(key: key);

  final CampingModel campingModel;
  final GestureTapCallback? onTapFavorite;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height / 815;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: totalHeight * 280,
        width: 205,
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Values.corners),
          child: Stack(
            children: [
              campingModel.campingPhotos.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: campingModel.campingPhotos[0],
                      imageBuilder: (context, imageProvider) => Container(
                        height: totalHeight * 280,
                        width: 220,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : noDataFound(themeFlag: true),
              Container(
                height: totalHeight * 280,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: const [0.5, 0.8],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.favorite_outline_rounded,
                            size: 25,
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(
                                  0.0,
                                  0.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 4.0,
                              ),
                            ],
                          ),
                          onPressed: onTapFavorite,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            campingModel.campingName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: totalHeight * 14,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                            width: 150,
                            child: Text(
                              campingModel.campingAddress,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: totalHeight * 14,
                              ),
                            ),
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
