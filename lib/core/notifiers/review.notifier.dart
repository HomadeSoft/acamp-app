import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/core/models/review.model.dart';
import 'package:campings_app/core/service/review.service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReviewNotifier extends ChangeNotifier {
  String? error;
  String? errorCode;
  late int reviewCount;

  final ReviewService reviewService = ReviewService();

  Future<bool> saveReview(
      {required ReviewModel reviewModel, required campingRating}) async {
    try {
      await reviewService.saveReview(reviewModel: reviewModel);
      double newRating =
          ((campingRating * reviewCount) + reviewModel.reviewStars) /
              (reviewCount + 1);
      await reviewService.saveCampingRating(reviewModel.campingId, newRating);
      return true;
    } on PostgrestException catch (e) {
      errorCode = e.code;
      if (errorCode == "23505") {
        error = Strings.alreadySubmittedReview;
      } else {
        error = e.message;
      }

      notifyListeners();
      return false;
    }
  }

  Future getReviewsForCamping({required int campingId}) async {
    var data = await reviewService.getReviewsForCamping(campingId);
    return data;
  }

  Future<int> getReviewCountForCamping({required int campingId}) async {
    var data = await reviewService.getReviewsCountForCamping(campingId);
    reviewCount = data;
    return data;
  }
}
