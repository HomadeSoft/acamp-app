import 'package:campings_app/core/api/supabase.api.dart';
import 'package:campings_app/core/models/favourite.model.dart';

class FavoriteService {
  Future<List<FavouriteModel>> getAllFavourite({required int userId}) async {
    var response = await SupabaseAPI.supabaseClient
        .from("favorite")
        .select("campings(*),favorite_id,user_id")
        .eq("user_id", userId);
    List<FavouriteModel> favoriteList = (response as List<dynamic>)
        .map((element) => FavouriteModel.fromJson(element))
        .toList();
    return favoriteList;
  }

  Future<FavouriteModel> addToFavourite(
      {required int userId, required int campingId}) async {
    var response = await SupabaseAPI.supabaseClient
        .from("favorite")
        .insert({
          "user_id": userId,
          "camping_id": campingId,
        })
        .select("campings(*),favorite_id,user_id")
        .single();
    return FavouriteModel.fromJson(response);
  }

  Future<FavouriteModel> deleteFromFavourite({required int favoriteId}) async {
    var response = await SupabaseAPI.supabaseClient
        .from("favorite")
        .delete()
        .eq("favorite_id", favoriteId)
        .select("campings(*),favorite_id,user_id")
        .single();
    return FavouriteModel.fromJson(response);
  }
}
