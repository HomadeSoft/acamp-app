import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/core/models/feedback.model.dart';
import 'package:campings_app/core/service/feedback.service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FeedbackNotifier extends ChangeNotifier {
  String? error;
  String? errorCode;

  final FeedbackService feedbackService = FeedbackService();

  Future<bool> saveFeedback({required FeedbackModel feedbackModel}) async {
    try {
      await feedbackService.saveFeedback(feedbackModel: feedbackModel);
      return true;
    } on PostgrestException catch (e) {
      errorCode = e.code;
      if (errorCode == "23505") {
        error = Strings.alreadySubmittedFeedback;
      } else {
        error = e.message;
      }

      notifyListeners();
      return false;
    }
  }
}
