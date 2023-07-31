import 'package:campings_app/core/models/events.model.dart';
import 'package:campings_app/core/service/events.service.dart';
import 'package:flutter/material.dart';

class EventsNotifier extends ChangeNotifier {
  final EventsService eventsService = EventsService();
  List<EventsModel>? allEvents;

  Future getAllEvents() async {
    if (allEvents == null) {
      allEvents = await eventsService.getAllEvents();
      notifyListeners();
    }
    return allEvents;
  }
}
