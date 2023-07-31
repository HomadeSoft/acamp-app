// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum CampingSort { ByPrice, ByRating, ByAmentities, Normal }

enum SortingSystem { ByAscendingOrder, ByDescendingOrder }

class SortNotifier extends ChangeNotifier {
  SortingSystem sortBySys = SortingSystem.ByAscendingOrder;
  CampingSort campingSort = CampingSort.Normal;

  void changeByAscendingOrder() {
    sortBySys = SortingSystem.ByAscendingOrder;
    notifyListeners();
  }

  void changeByDescendingOrder() {
    sortBySys = SortingSystem.ByDescendingOrder;
    notifyListeners();
  }

  void changeByPrice() {
    campingSort = CampingSort.ByPrice;
    notifyListeners();
  }

  void changeByRating() {
    campingSort = CampingSort.ByRating;
    notifyListeners();
  }

  void changeByAmentities() {
    campingSort = CampingSort.ByAmentities;
    notifyListeners();
  }

  void changeNormal() {
    campingSort = CampingSort.Normal;
    notifyListeners();
  }
}
