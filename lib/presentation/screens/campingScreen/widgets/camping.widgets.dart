import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/app/constants/app.values.dart';
import 'package:campings_app/core/models/camping.model.dart';
import 'package:campings_app/presentation/screens/campingScreen/widgets/camping.review.dart';
import 'package:campings_app/presentation/screens/campingScreen/widgets/image.slider.dart';
import 'package:campings_app/presentation/screens/campingScreen/widgets/camping.footer.dart';
import 'package:flutter/material.dart';

Widget buildCampingData({
  required BuildContext context,
  required CampingModel campingModel,
  required themeFlag,
}) {
  return SingleChildScrollView(
    child: Column(
      children: [
        imageSlider(campingModel: campingModel, context: context),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
          decoration: BoxDecoration(
            color: themeFlag ? AppColors.mirage : AppColors.creamColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(100),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      campingModel.campingName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:
                            themeFlag ? AppColors.creamColor : AppColors.mirage,
                      ),
                    ),
                    Text(
                      "${Strings.priceTag} ${campingModel.campingPrice.toString()}",
                      style: const TextStyle(
                          color: AppColors.yellowish,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: themeFlag
                              ? AppColors.creamColor
                              : AppColors.mirage,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          campingModel.campingAddress,
                          style: TextStyle(
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      Strings.perNight,
                      style: TextStyle(
                        color:
                            themeFlag ? AppColors.creamColor : AppColors.mirage,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ReviewSummaryBox(themeFlag: themeFlag, camping: campingModel),
              const SizedBox(
                height: 5,
              ),
              Text(
                Strings.offers,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
                child: ListView.builder(
                  itemCount: campingModel.campingAmenitiesImages.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return SizedBox(
                      width: 100,
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Values.corners),
                            ),
                            child: Container(
                              // width: 100,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Values.corners),
                                  color: AppColors.primaryGreen),
                              child: campingModel
                                      .campingAmenitiesImages[index].isNotEmpty
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(Values.corners),
                                      child: Image.network(
                                        campingModel
                                            .campingAmenitiesImages[index],
                                        height: 50,
                                        width: 50,
                                      ),
                                    )
                                  : const Icon(Icons.image_not_supported,
                                      color: AppColors.yellowish),
                            ),
                          ),
                          Text(
                            campingModel.campingAmenitiesText[index],
                            maxLines: 2,
                            style: const TextStyle(color: AppColors.yellowish),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                Strings.description,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                ),
              ),
              Text(
                campingModel.campingDescription,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                Strings.services,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                ),
              ),
              Text(
                campingModel.campingWater != null
                    ? "${Strings.waterOption} ${campingModel.campingWater}"
                    : Strings.waterUnspecified,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                ),
              ),
              Text(
                campingModel.campingLight != null
                    ? "${Strings.lightOption} ${campingModel.campingLight}"
                    : Strings.lightUnspecified,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                ),
              ),
              Text(
                campingModel.campingCleaning != null
                    ? "${Strings.cleanOption} ${campingModel.campingCleaning}"
                    : Strings.cleanUnspecified,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CampingFooter(
                campingModel: campingModel,
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
