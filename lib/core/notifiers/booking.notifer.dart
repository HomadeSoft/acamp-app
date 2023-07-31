import 'package:campings_app/core/models/booking.model.dart';
import 'package:campings_app/core/service/booking.service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookingNotifier extends ChangeNotifier {
  final BookingService bookingService = BookingService();
  String? error;

  Future getSpecificCamping({required int userId}) async {
    var data = await bookingService.getBookingData(userId: userId);
    return data;
  }

  Future<bool> confirmBooking({
    required BookingModel bookingModel,
    required int userId,
    required int campingId,
  }) async {
    try {
      await bookingService.confirmBooking(
        bookingModel: bookingModel,
        userId: userId,
        campingId: campingId,
      );
      return true;
    } on PostgrestException catch (e) {
      error = e.message;
      notifyListeners();
      return false;
    }
  }

  String? startDate;
  String? endDate;

  void startDateSet({required String createdAt}) {
    startDate = createdAt;
    notifyListeners();
  }

  void endDateSet({required String createdAt}) {
    endDate = createdAt;
    notifyListeners();
  }
}
