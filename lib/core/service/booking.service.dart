import 'package:campings_app/core/api/supabase.api.dart';
import 'package:campings_app/core/models/booking.model.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookingService {
  Future<BookingModel?> getBookingData({required int userId}) async {
    try {
      var response = await SupabaseAPI.supabaseClient
          .from("bookings")
          .select(
              "booking_price,booking_start_date,booking_end_date,campings(*)")
          .eq("user_id", userId)
          .single();
      return BookingModel.fromJson(response);
    } on PostgrestException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return null;
    }
  }

  Future<BookingModel?> confirmBooking({
    required BookingModel bookingModel,
    required int userId,
    required int campingId,
  }) async {
    try {
      var response = await SupabaseAPI.supabaseClient
          .from("bookings")
          .insert({
            "camping_id": campingId,
            "user_id": userId,
            "booking_price": bookingModel.bookingPrice,
            "booking_start_date": bookingModel.bookingStartDate,
            "booking_end_date": bookingModel.bookingEndDate,
          })
          .select()
          .single();
      return BookingModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }
}
