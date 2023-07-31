import 'package:campings_app/core/api/supabase.api.dart';
import 'package:campings_app/core/models/review.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReviewService {
  Future<ReviewModel?> saveReview({required ReviewModel reviewModel}) async {
    var response = await SupabaseAPI.supabaseClient
        .from("reviews")
        .insert({
          "created_at": reviewModel.createdAt.toString(),
          "user_id": reviewModel.userId,
          "review_title": reviewModel.reviewTitle,
          "review_description": reviewModel.reviewDescription,
          "review_stars": reviewModel.reviewStars,
          "camping_id": reviewModel.campingId,
        })
        .select()
        .single();
    return ReviewModel.fromJson(response);
  }

  Future<List<ReviewModel>> getReviewsForCamping(int campingId) async {
    var response = await SupabaseAPI.supabaseClient
        .from("reviews")
        .select()
        .eq("camping_id", campingId);
    List<ReviewModel> reviewList = (response as List<dynamic>)
        .map((element) => ReviewModel.fromJson(element))
        .toList();
    return reviewList;
  }

  Future<int> getReviewsCountForCamping(int campingId) async {
    var response = await SupabaseAPI.supabaseClient
        .from("reviews")
        .select('*', const FetchOptions(count: CountOption.exact, head: true))
        .eq("camping_id", campingId);
    return response.count;
  }

  Future saveCampingRating(int campingId, campingRating) async {
    await SupabaseAPI.supabaseClient
        .from("campings")
        .update({
          "camping_rating": campingRating,
        })
        .eq("camping_id", campingId)
        .single();
    return;
  }
}
