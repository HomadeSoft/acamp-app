// ignore_for_file: prefer_function_declarations_over_variables

import 'package:campings_app/core/models/camping.model.dart';
import 'package:campings_app/core/notifiers/sorts.notifier.dart';
import 'package:campings_app/core/service/camping.service.dart';
import 'package:flutter/material.dart';

class CampingNotifier extends ChangeNotifier {
  final CampingService campingService = CampingService();

  Future getAllCampings(
      {required CampingSort campingSort, required SortingSystem sortBy}) async {
    List<CampingModel> campingList = await campingService.getAllCampings();

    if (sortBy == SortingSystem.ByAscendingOrder) {
      if (campingSort == CampingSort.Normal) {
        return campingList;
      } else if (campingSort == CampingSort.ByPrice) {
        Comparator<CampingModel> priceComparator =
            (a, b) => a.campingPrice.compareTo(b.campingPrice);
        campingList.sort(priceComparator);
        return campingList;
      } else if (campingSort == CampingSort.ByRating) {
        Comparator<CampingModel> ratingComp =
            (a, b) => a.campingPrice.compareTo(b.campingPrice);
        campingList.sort(ratingComp);
        return campingList;
      } else if (campingSort == CampingSort.ByAmentities) {
        Comparator<CampingModel> amentitiesComp = (a, b) => a
            .campingAmenitiesImages.length
            .compareTo(b.campingAmenitiesImages.length);
        campingList.sort(amentitiesComp);
        return campingList;
      }
    } else if (sortBy == SortingSystem.ByDescendingOrder) {
      if (campingSort == CampingSort.Normal) {
        return campingList;
      } else if (campingSort == CampingSort.ByPrice) {
        Comparator<CampingModel> priceComparator =
            (a, b) => b.campingPrice.compareTo(a.campingPrice);
        campingList.sort(priceComparator);
        return campingList;
      } else if (campingSort == CampingSort.ByRating) {
        Comparator<CampingModel> ratingComp =
            (a, b) => b.campingPrice.compareTo(a.campingPrice);
        campingList.sort(ratingComp);
        return campingList;
      } else if (campingSort == CampingSort.ByAmentities) {
        Comparator<CampingModel> amentitiesComp = (a, b) => b
            .campingAmenitiesImages.length
            .compareTo(a.campingAmenitiesImages.length);
        campingList.sort(amentitiesComp);
        return campingList;
      }
    }
  }

  Future getSpecificCamping({required int campingId}) async {
    var data = await campingService.getSpecificCamping(campingId: campingId);
    return data;
  }

  Future getSearchCampings({required String campingName}) async {
    var data = await campingService.getSearchCampings(campingName: campingName);
    return data;
  }

  Future getNearbyCampings() async {
    var data = await campingService.getNearbyCampings();
    return data;
  }
}
