import 'dart:convert';

List<CampingModel> campingModelFromJson(String str) => List<CampingModel>.from(
    json.decode(str).map((x) => CampingModel.fromJson(x)));

String campingModelToJson(List<CampingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CampingModel {
  CampingModel({
    required this.campingId,
    required this.createdAt,
    required this.campingName,
    required this.campingType,
    required this.campingAddress,
    required this.campingPrice,
    required this.campingPhotos,
    required this.campingStatus,
    required this.campingRating,
    required this.campingDescription,
    required this.campingCallNo,
    required this.campingLat,
    required this.campingLong,
    required this.campingLight,
    required this.campingWater,
    required this.campingCleaning,
  });

  int campingId;
  String createdAt;
  String campingName;
  String campingType;
  String campingAddress;
  String campingDescription;
  int campingPrice;
  String campingCallNo;
  double campingLat;
  double campingLong;
  double campingRating;
  List<String> campingAmenitiesText = List.empty(growable: true);
  List<String> campingAmenitiesImages = List.empty(growable: true);
  List<String> campingPhotos;
  bool campingStatus;
  String? campingLight;
  String? campingWater;
  String? campingCleaning;

  factory CampingModel.fromJson(Map<String, dynamic> json) => CampingModel(
        campingRating: json["camping_rating"].toDouble(),
        campingId: json["camping_id"],
        createdAt: json["created_at"],
        campingName: json["camping_name"],
        campingType: json["camping_type"],
        campingDescription: json["camping_description"],
        campingAddress: json["camping_address"],
        campingPrice: json["camping_price"],
        campingPhotos: List<String>.from(json["camping_photos"].map((x) => x)),
        campingStatus: json["camping_status"],
        campingCallNo: json['camping_phone_call'],
        campingLat: json['camping_lat'],
        campingLong: json['camping_long'],
        campingLight: json['camping_light'],
        campingWater: json['camping_water'],
        campingCleaning: json['camping_cleaning'],
      );

  Map<String, dynamic> toJson() => {
        "camping_id": campingId,
        "created_at": createdAt,
        "camping_name": campingName,
        "camping_type": campingType,
        "camping_address": campingAddress,
        "camping_price": campingPrice,
        "camping_photos": List<dynamic>.from(campingPhotos.map((x) => x)),
        "camping_status": campingStatus,
        "camping_rating": campingRating,
        "camping_description": campingDescription,
        "camping_long": campingLong,
        "camping_lat": campingLat,
        "camping_phone_call": campingCallNo,
        "camping_water": campingWater,
        "camping_light": campingLight,
        "camping_cleaning": campingCleaning,
      };

  addAmenity(displayName, imagePath) {
    campingAmenitiesText.add(displayName);
    campingAmenitiesImages.add(imagePath);
  }
}
