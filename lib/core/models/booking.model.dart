// To parse this JSON data, do
//
//     final bookingModel = bookingModelFromJson(jsonString);

import 'dart:convert';

import 'package:campings_app/core/models/camping.model.dart';

List<BookingModel> bookingModelFromJson(String str) => List<BookingModel>.from(
    json.decode(str).map((x) => BookingModel.fromJson(x)));

String bookingModelToJson(List<BookingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingModel {
  BookingModel({
    required this.bookingPrice,
    required this.bookingStartDate,
    required this.bookingEndDate,
    this.campings,
  });

  int bookingPrice;
  String bookingStartDate;
  String bookingEndDate;
  CampingModel? campings;

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        bookingPrice: json["booking_price"],
        bookingStartDate: json["booking_start_date"],
        bookingEndDate: json["booking_end_date"],
        campings: CampingModel.fromJson(json["campings"]),
      );

  Map<String, dynamic> toJson() => {
        "booking_price": bookingPrice,
        "booking_start_date": bookingStartDate,
        "booking_end_date": bookingEndDate,
        "campings": campings?.toJson(),
      };
}
