import 'dart:convert';

List<ReviewModel> reviewModelFromJson(String str) => List<ReviewModel>.from(
    json.decode(str).map((x) => ReviewModel.fromJson(x)));

String reviewModelToJson(List<ReviewModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReviewModel {
  ReviewModel({
    this.reviewId,
    required this.createdAt,
    required this.reviewTitle,
    required this.reviewDescription,
    required this.reviewStars,
    required this.userId,
    required this.campingId,
  });

  int? reviewId;
  String createdAt;
  String reviewTitle;
  String reviewDescription;
  double reviewStars;
  int userId;
  int campingId;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        reviewId: json["review_id"],
        createdAt: json["created_at"],
        reviewTitle: json["review_title"],
        reviewDescription: json["review_description"],
        reviewStars: json["review_stars"].toDouble(),
        userId: json["user_id"],
        campingId: json["camping_id"],
      );

  Map<String, dynamic> toJson() => {
        "review_id": reviewId,
        "created_at": createdAt,
        "review_title": reviewTitle,
        "review_description": reviewDescription,
        "review_stars": reviewStars,
        "user_id": userId,
        "camping_id": campingId,
      };
}
