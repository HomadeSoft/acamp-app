import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/core/models/favourite.model.dart';
import 'package:campings_app/core/service/favourite.service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavouriteNotifier extends ChangeNotifier {
  String? error;
  final FavoriteService favoriteService = FavoriteService();
  List<FavouriteModel>? allFavData;

  Future getAllFavourite({required int userId}) async {
    allFavData = await favoriteService.getAllFavourite(userId: userId);
    return allFavData;
  }

  Future<bool> addToFavourite(
      {required int userId, required int campingId}) async {
    try {
      await favoriteService.addToFavourite(
          userId: userId, campingId: campingId);
      return true;
    } on PostgrestException catch (e) {
      if (e.code == "23505") {
        error = Strings.alreadyAdded;
      } else {
        error = e.message;
      }
      return false;
    }
  }

  Future<bool> deleteFromFavourite({
    required int favoriteId,
  }) async {
    try {
      await favoriteService.deleteFromFavourite(favoriteId: favoriteId);
      notifyListeners();
      return true;
    } on PostgrestException catch (e) {
      error = e.message;
      notifyListeners();
      return false;
    }
  }
}
