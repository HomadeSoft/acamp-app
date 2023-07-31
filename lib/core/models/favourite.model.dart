// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'dart:convert';

import 'package:campings_app/core/models/camping.model.dart';

List<FavouriteModel> favoriteModelFromJson(String str) =>
    List<FavouriteModel>.from(
        json.decode(str).map((x) => FavouriteModel.fromJson(x)));

String favoriteModelToJson(List<FavouriteModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavouriteModel {
  FavouriteModel({
    required this.favoriteId,
    required this.userId,
    required this.campings,
  });

  int favoriteId;
  int userId;
  CampingModel campings;

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
        favoriteId: json["favorite_id"],
        userId: json["user_id"],
        campings: CampingModel.fromJson(json["campings"]),
      );

  Map<String, dynamic> toJson() => {
        "favorite_id": favoriteId,
        "user_id": userId,
        "campings": campings.toJson(),
      };
}
