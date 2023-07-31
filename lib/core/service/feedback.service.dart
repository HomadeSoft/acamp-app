import 'package:campings_app/core/api/supabase.api.dart';
import 'package:campings_app/core/models/feedback.model.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FeedbackService {
  Future<FeedbackModel?> saveFeedback(
      {required FeedbackModel feedbackModel}) async {
    try {
      PostgrestResponse response = await SupabaseAPI.supabaseClient
          .from("feedback")
          .insert({
            "created_at": feedbackModel.createdAt.toString(),
            "user_id": feedbackModel.userId,
            "feedback_title": feedbackModel.feedbackTitle,
            "feedback_description": feedbackModel.feedbackDescription,
            "feedback_stars": feedbackModel.feedbackStars,
          })
          .select()
          .single();
      return FeedbackModel.fromJson(response.data);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }
}
